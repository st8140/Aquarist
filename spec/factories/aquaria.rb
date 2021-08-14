FactoryBot.define do
  factory :aquarium do
    sequence(:aquarium_introduction) { |n| "this is a test introduction#{n}" }
    aquarium_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg')) }
    association :user
  end
end
