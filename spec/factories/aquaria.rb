FactoryBot.define do
  factory :aquarium do
    sequence(aquarium_introduction) { |n| "this is a test introduction#{n}" }
    aquarium_image { Rack::Test::UploadedFile.new(Rails.root.join('app/assets/images/no_image.jpg')) }
    association :user
  end
end
