require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:relationship) { create(:relationship) }

  it "follow_id、follower_idがあれば有効であること" do
    expect(relationship).to be_valid
  end

  it "follow_idが無ければ無効であること" do
    relationship.following_id = nil
    expect(relationship).to be_invalid
  end

  it "follower_idが無ければ無効であること" do
    relationship.follower_id = nil
    expect(relationship).to be_invalid
  end
end
