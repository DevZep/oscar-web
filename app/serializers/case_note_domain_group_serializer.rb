class CaseNoteDomainGroupSerializer < ActiveModel::Serializer
  attributes :note, :case_note_id, :domain_group_id, :id, :domain_scores

  has_many :tasks

  def domain_scores
    domain_scores = object.domains(object.case_note).map do |domain|
      ad = domain.assessment_domains.find_by(assessment_id: object.case_note.assessment_id)
      { domain_id: ad.domain_id, score: ad.score } if ad.present?
    end.compact
  end
end
