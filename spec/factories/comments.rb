FactoryBot.define do
  factory :comment do
    content { "MyString" }
    user { nil }
    aquarium { nil }
  end
end
