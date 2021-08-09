FactoryBot.define do
  factory :like do
    association :aquarium
    association :user
  end
end
