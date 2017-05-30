require 'spec_helper'

describe ClientSerializer, type: :serializer do
  let(:user) { create(:user) }
  let(:client) { create(:client, user: user) }
  let(:serializer) { ClientSerializer.new(client).to_json }

  it 'should be have attribute client as root path' do
    expect(serializer).to have_json_size(1)
    expect(serializer).to have_json_type(Object).at_path('client')
  end

  it 'should be have attribute id' do
    expect(serializer).to have_json_path('client/id')
    expect(serializer).to have_json_type(Integer).at_path('client/id')
  end

  it 'should be have attribute code' do
    expect(serializer).to have_json_path('client/code')
    expect(serializer).to have_json_type(String).at_path('client/code')
  end

  it 'should be have attribute given_name' do
    expect(serializer).to have_json_path('client/given_name')
    expect(serializer).to have_json_type(String).at_path('client/given_name')
  end

  it 'should be have attribute local_given_name' do
    expect(serializer).to have_json_path('client/local_given_name')
    expect(serializer).to have_json_type(String).at_path('client/local_given_name')
  end

  it 'should be have attribute family_name' do
    expect(serializer).to have_json_path('client/family_name')
    expect(serializer).to have_json_type(String).at_path('client/family_name')
  end

  it 'should be have attribute local_family_name' do
    expect(serializer).to have_json_path('client/local_family_name')
    expect(serializer).to have_json_type(String).at_path('client/local_family_name')
  end

  it 'should be have attribute gender' do
    expect(serializer).to have_json_path('client/gender')
    expect(serializer).to have_json_type(String).at_path('client/gender')
  end

  it 'should be have attribute date_of_birth' do
    expect(serializer).to have_json_path('client/date_of_birth')
    expect(serializer).to have_json_type(String).at_path('client/date_of_birth')
  end

  it 'should be have attribute status' do
    expect(serializer).to have_json_path('client/status')
    expect(serializer).to have_json_type(String).at_path('client/status')
  end

  it 'should be have attribute current_province' do
    expect(serializer).to have_json_path('client/current_province')
    expect(serializer).to have_json_type(Object).at_path('client/current_province')
  end

  it 'should be have attribute kid_id' do
    expect(serializer).to have_json_path('client/kid_id')
    expect(serializer).to have_json_type(String).at_path('client/kid_id')
  end

  it 'should be have attribute donor_name' do
    expect(serializer).to have_json_path('client/donor_name')
    expect(serializer).to have_json_type(NilClass).at_path('client/donor_name')
  end

  it 'should be have attribute current_address' do
    expect(serializer).to have_json_path('client/current_address')
    expect(serializer).to have_json_type(String).at_path('client/current_address')
  end

  it 'should be have attribute house_number' do
    expect(serializer).to have_json_path('client/house_number')
    expect(serializer).to have_json_type(String).at_path('client/house_number')
  end

  it 'should be have attribute street_number' do
    expect(serializer).to have_json_path('client/street_number')
    expect(serializer).to have_json_type(String).at_path('client/street_number')
  end

  it 'should be have attribute village' do
    expect(serializer).to have_json_path('client/village')
    expect(serializer).to have_json_type(String).at_path('client/village')
  end

  it 'should be have attribute commune' do
    expect(serializer).to have_json_path('client/commune')
    expect(serializer).to have_json_type(String).at_path('client/commune')
  end

  it 'should be have attribute district' do
    expect(serializer).to have_json_path('client/district')
    expect(serializer).to have_json_type(String).at_path('client/district')
  end

  it 'should be have attribute completed' do
    expect(serializer).to have_json_path('client/completed')
    expect(serializer).to have_json_type(:boolean).at_path('client/completed')
  end

  it 'should be have attribute birth_province' do
    expect(serializer).to have_json_path('client/birth_province')
    expect(serializer).to have_json_type(Object).at_path('client/birth_province')
  end

  it 'should be have attribute time_in_care' do
    expect(serializer).to have_json_path('client/time_in_care')
    expect(serializer).to have_json_type(NilClass).at_path('client/time_in_care')
  end

  it 'should be have attribute initial_referral_date' do
    expect(serializer).to have_json_path('client/initial_referral_date')
    expect(serializer).to have_json_type(NilClass).at_path('client/initial_referral_date')
  end

  it 'should be have attribute referral_source' do
    expect(serializer).to have_json_path('client/referral_source')
    expect(serializer).to have_json_type(Object).at_path('client/referral_source')
  end

  it 'should be have attribute referral_phone' do
    expect(serializer).to have_json_path('client/referral_phone')
    expect(serializer).to have_json_type(String).at_path('client/referral_phone')
  end

  it 'should be have attribute who_live_with' do
    expect(serializer).to have_json_path('client/who_live_with')
    expect(serializer).to have_json_type(String).at_path('client/who_live_with')
  end

  it 'should be have attribute poverty_certificate' do
    expect(serializer).to have_json_path('client/poverty_certificate')
    expect(serializer).to have_json_type(Integer).at_path('client/poverty_certificate')
  end

  it 'should be have attribute rice_support' do
    expect(serializer).to have_json_path('client/rice_support')
    expect(serializer).to have_json_type(Integer).at_path('client/rice_support')
  end

  it 'should be have attribute received_by' do
    expect(serializer).to have_json_path('client/received_by')
    expect(serializer).to have_json_type(Object).at_path('client/received_by')
  end

  it 'should be have attribute followed_up_by' do
    expect(serializer).to have_json_path('client/followed_up_by')
    expect(serializer).to have_json_type(Object).at_path('client/followed_up_by')
  end

  it 'should be have attribute follow_up_date' do
    expect(serializer).to have_json_path('client/follow_up_date')
    expect(serializer).to have_json_type(NilClass).at_path('client/follow_up_date')
  end

  it 'should be have attribute school_name' do
    expect(serializer).to have_json_path('client/school_name')
    expect(serializer).to have_json_type(String).at_path('client/school_name')
  end

  it 'should be have attribute school_grade' do
    expect(serializer).to have_json_path('client/school_grade')
    expect(serializer).to have_json_type(String).at_path('client/school_grade')
  end

  it 'should be have attribute has_been_in_orphanage' do
    expect(serializer).to have_json_path('client/has_been_in_orphanage')
    expect(serializer).to have_json_type(:boolean).at_path('client/has_been_in_orphanage')
  end

  it 'should be have attribute able_state' do
    expect(serializer).to have_json_path('client/able_state')
    expect(serializer).to have_json_type(String).at_path('client/able_state')
  end

  it 'should be have attribute has_been_in_government_care' do
    expect(serializer).to have_json_path('client/has_been_in_government_care')
    expect(serializer).to have_json_type(:boolean).at_path('client/has_been_in_government_care')
  end

  it 'should be have attribute relevant_referral_information' do
    expect(serializer).to have_json_path('client/relevant_referral_information')
    expect(serializer).to have_json_type(String).at_path('client/relevant_referral_information')
  end

  it 'should be have attribute case_worker' do
    expect(serializer).to have_json_path('client/case_worker')
    expect(serializer).to have_json_type(Object).at_path('client/case_worker')
  end

  it 'should be have attribute agencies' do
    expect(serializer).to have_json_path('client/agencies')
    expect(serializer).to have_json_type(Array).at_path('client/agencies')
  end

  it 'should be have attribute state' do
    expect(serializer).to have_json_path('client/state')
    expect(serializer).to have_json_type(String).at_path('client/state')
  end

  it 'should be have attribute rejected_note' do
    expect(serializer).to have_json_path('client/rejected_note')
    expect(serializer).to have_json_type(NilClass).at_path('client/rejected_note')
  end

  it 'should be have attribute emergency_case' do
    expect(serializer).to have_json_path('client/emergency_case')
    expect(serializer).to have_json_type(Array).at_path('client/emergency_case')
  end

  it 'should be have attribute organization' do
    expect(serializer).to have_json_path('client/organization')
    expect(serializer).to have_json_type(Object).at_path('client/organization')
  end
end