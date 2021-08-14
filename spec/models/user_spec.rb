require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user, email: "test@example.com") }
  before(:each) do
    # @user = FactoryBot.build(:user)
  end

  it "名前、メールアドレス、パスワードがあれば有効であること" do
    expect(user).to be_valid
  end

  it "名前が無ければ無効な状態であること" do
    user.name = nil
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it "メールアドレスが無ければ無効な状態であること" do
    user.email = nil
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  it "パスワードが無ければ無効な状態であること" do
    user.password = nil
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  it "重複したメールアドレスは無効であること" do
    @user = build(:user, email: "test@example.com")
    @user.valid?
    expect(@user.errors[:email]).to include("はすでに存在します")
  end
end
