require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:like) { create(:like) }

  it "user_id、post_idがあれば有効であること" do
    expect(like).to be_valid
  end

  it "user_idが無ければ無効であること" do
    like.user_id = nil
    expect(like).to be_invalid
  end

  it "aquarium_idが無ければ無効であること" do
    like.aquarium_id = nil
    expect(like).to be_invalid
  end

end
