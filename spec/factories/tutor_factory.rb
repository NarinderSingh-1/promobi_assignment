FactoryBot.define do
  factory :tutor do
    sequence(:name)  { |n| "Tutor #{n}" }
    sequence(:email) { |n| "tutor#{n}@example.com" }
    sequence(:phone) { |n| "123456789#{n}" }

    association :course
  end
end
