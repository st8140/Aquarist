require 'rails_helper'

RSpec.describe Aquarium, type: :model do
  let(:user) { create(:user) }
  let(:aquarium) { create(:aquarium, user_id: user.id) }

  it "投稿内容、画像、user_idがあれば有効" do
    expect(aquarium).to be_valid
  end

  it "投稿内容が無ければ無効" do
    aquarium.aquarium_introduction = nil
    aquarium.valid?
    expect(aquarium.errors[:aquarium_introduction]).to include("を入力してください")
  end

  it "画像が無ければ無効" do
    aquarium.aquarium_image = nil
    aquarium.valid?
    expect(aquarium.errors[:aquarium_image]).to include("を選択してください")
  end

  it "user_idが無ければ無効" do
    aquarium.user_id = nil
    expect(aquarium).to be_invalid
  end


end
