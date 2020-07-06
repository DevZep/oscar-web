class Commune < ActiveRecord::Base
  attr_accessor :name
  has_paper_trail

  belongs_to :district
  has_many :villages, dependent: :restrict_with_error
  has_many :government_forms, dependent: :restrict_with_error
  has_many :clients, dependent: :restrict_with_error
  has_many :families, dependent: :restrict_with_error
  has_many :settings, dependent: :restrict_with_error

  validates :district, :name_kh, :name_en, presence: true
  validates :code, presence: true, uniqueness: true

  scope :dropdown_list_option, -> { all.map{|c| { c.id => c.name } } }


  def name
    "#{name_kh} / #{name_en}"
  end

  def code_format
    "#{name_kh} / #{name_en} (#{code})"
  end

  def self.get_commune(commune_code)
    commune = find_by(code: commune_code)
    if commune
      { village_id: nil, commune_id: commune.id, district_id: commune.district&.id, province_id: commune.district.province&.id }
    else
      { commune_id: nil }
    end
  end
end
