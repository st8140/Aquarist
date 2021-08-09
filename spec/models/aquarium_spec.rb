require 'rails_helper'

RSpec.describe Aquarium, type: :model do
  let(:image_path) { File.join(Rails.root, 'app/assets/images/no_image.jpg') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }

  before do
    @user = FactoryBot.create(:user)
    @aquarium = Aquarium.create(
      aquarium_introduction: "test",
      aquarium_image: image,
      user_id: @user.id
    )
  end

  it "投稿内容、画像、user_idがあれば有効" do
    expect(@aquarium).to be_valid
  end

  it "投稿内容が無ければ無効" do
    @aquarium.aquarium_introduction = nil
    @aquarium.valid?
    expect(@aquarium.errors[:aquarium_introduction]).to include("を入力してください")
  end

  it "画像が無ければ無効" do
    @aquarium.aquarium_image = nil
    @aquarium.valid?
    expect(@aquarium.errors[:aquarium_image]).to include("を選択してください")
  end

  it "user_idが無ければ無効" do
    @aquarium.user_id = nil
    expect(@aquarium).to be_invalid
  end


end
