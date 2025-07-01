class Course < ApplicationRecord
  DURATIONS = ['3_months', '6_months', '12_months', '18_months', '2_years', '3_years'].freeze

  has_many :tutors, inverse_of: :course, dependent: :destroy

  accepts_nested_attributes_for :tutors, allow_destroy: true

  validates :name,     presence: true
  validates :duration, presence: true
  validates :duration, inclusion: { in: DURATIONS }
end
