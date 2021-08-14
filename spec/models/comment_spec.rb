require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { create(:comment) }

  it "content, user_id, aquarium_idがあれば有効であること" do
    expect(comment).to be_valid
  end

  it "contentが無ければば無効であること" do
    comment.content = nil
    expect(comment).to be_invalid
  end

  it "user_idが無ければば無効であること" do
    comment.user_id = nil
    expect(comment).to be_invalid
  end

  it "contentが無ければば無効であること" do
    comment.aquarium_id = nil
    expect(comment).to be_invalid
  end


end
