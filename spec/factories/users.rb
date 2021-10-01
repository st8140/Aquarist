FactoryBot.define do
  factory :user, aliases: [:following, :follower] do
    sequence(:name) { |n| "testuser_#{n}" }
    sequence(:email) { |n| "test#{n}@example.com"}
    user_image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/test_user.png')) }
    password { "testuser" }
  end
end
