FactoryBot.define do
  factory :comment do
    sequence(:content) { |n| "test comment_#{n}" }
    association :user
    association :aquarium
  end
end
