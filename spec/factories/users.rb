FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "testuser_#{n}" }
    sequence(:email) { |n| "test#{n}@example.com"}
    password { "testuser" }
  end
end
