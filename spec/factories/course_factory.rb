FactoryBot.define do
  factory :course do
    name        { "Ruby on Rails" }
    description { "Backend development with Rails" }
    duration    { Course::DURATIONS.sample }

    trait :with_tutors do
      after(:create) do |course|
        create_list(:tutor, 2, course: course)
      end
    end
  end
end
