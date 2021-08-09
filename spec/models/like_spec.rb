require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:image_path) { File.join(Rails.root, 'spec/fixtures/test.jpg') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }
  let(:user) { create(:user) }

  before do
    @aquarium = Aquarium.create(
      aquarium_introduction: "test",
      aquarium_image: image,
      user_id: user.id
    )
    @like = Like.create(
      user_id: user.id,
      aquarium_id: @aquarium.id
    )
  end

  it "user_id、post_idがあれば有効であること" do
    expect(@like).to be_valid
  end

  it "user_idが無ければ無効であること" do
    @like.user_id = nil
    expect(@like).to be_invalid
  end

  it "aquarium_idが無ければ無効であること" do
    @like.aquarium_id = nil
    expect(@like).to be_invalid
  end

end
