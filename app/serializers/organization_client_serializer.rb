class OrganizationClientSerializer < ActiveModel::Serializer
  include ActionView::Helpers::AssetUrlHelper

  attributes :slug, :global_id, :external_id, :external_id_display, :mosvy_number, :mosvy_number, :given_name, :family_name,
             :gender, :date_of_birth, :location_current_village_code, :address_current_village_code,
             :organization_id, :organization_name, :external_case_worker_name, :external_case_worker_id, :reason_for_referral,
             :services, :status, :case_worker_name, :case_worker_mobile, :is_referred, :referral_consent_form, :organization_address_code

  def organization_id
    Organization.current.id
  end

  def organization_name
    Organization.current.short_name
  end

  def is_referred
    return false if object.referrals.externals.last.nil?
    referral        = object.referrals.externals.last
    external_system = referral.external_system
    external_system&.token == context.uid
  end

  def referral_consent_form
    return [] unless object.referrals.externals.last.present? || is_referred
    referral = object.referrals.externals.last
    referral.consent_form.map do |attachment|
      asset_path(attachment.url)
    end
  end

  def services
    service_types = object.program_streams.joins(:services).distinct.map do |ps|
      enrollment_date = object.client_enrollments.where(program_stream_id: ps.id).first&.enrollment_date&.to_s
      ps.services.map do |service|
        {
          enrollment_date: enrollment_date,
          uuid: service.uuid,
          name: service.name
        }
      end
    end.compact.flatten.uniq
  end

  def case_worker_name
    object.users.map(&:name).reject(&:blank?).join(", ")
  end

  def case_worker_mobile
    object.users.map(&:mobile).reject(&:blank?).join(", ")
  end

  def organization_address_code
    setting = Setting.first
    return '' unless setting.province
    if setting.commune
      setting.commune.code
    elsif setting.district
      setting.district.code
    else
      setting.province.district.first.code
    end
  end

  def location_current_village_code
    object.village&.code || ""
  end

  def address_current_village_code
    object.village&.code || ""
  end
end
