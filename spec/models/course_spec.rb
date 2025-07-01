require 'rails_helper'

RSpec.describe Course, type: :model do

  describe 'associations' do
    it { is_expected.to have_many(:tutors).dependent(:destroy) }
    it { is_expected.to accept_nested_attributes_for(:tutors).allow_destroy(true) }
  end

  describe 'validations' do
    subject { build_stubbed(:course) }

    let(:durations) { Course::DURATIONS }

    it { is_expected.to be_valid }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:duration) }
    it { is_expected.to validate_inclusion_of(:duration).in_array(durations) }
  end

  it "is invalid with an invalid duration" do
    course = build_stubbed(:course, duration: '5_weeks')

    expect(course).not_to be_valid
    expect(course.errors[:duration]).to include("is not included in the list")
  end
end
