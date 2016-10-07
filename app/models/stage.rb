class Stage < ActiveRecord::Base

  MEASUREMENTS = %w(month year).freeze

  has_many :able_screening_questions, dependent: :destroy
  validates :from_age, :to_age, presence: true
  accepts_nested_attributes_for :able_screening_questions, reject_if: :all_blank, allow_destroy: true

  def from_age_as_date
    (from_age * 12).to_i.months.ago.to_date.end_of_month
  end

  def to_age_as_date
    (to_age * 12).to_i.months.ago.to_date.beginning_of_month
  end
end
