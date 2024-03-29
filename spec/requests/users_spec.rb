require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:aquarium) { create(:aquarium, user_id: user.id) }
  let!(:like) { create(:like, user_id: user.id, aquarium_id: aquarium.id) }
  
  describe "GET /registrations/new" do
    it "アカウント登録画面の表示に成功すること" do
      get new_user_registration_path
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /session/new" do
    it "ログイン画面の表示に成功すること" do
      get new_user_session_path
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /registrations/detail" do
    before do
      sign_in user
      get detail_path(user)
    end

    it "アカウント画面の表示に成功すること" do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "名前が正常に表示される" do
      expect(response.body).to include(user.name)
    end

    it "アカウント画像が正常に表示される" do
      expect(response.body).to include(user.user_image.to_s)
    end

    it "カバー画像が正常に表示される" do
      expect(response.body).to include("profile_default_image")
    end
    
    it "自己紹介が正常に表示される" do
      user.introduction = "test"
      expect(response.body).to include(user.introduction)
    end

  end

  describe "GET /users/password/new" do
    it "パスワード再設定送信画面の表示に成功すること" do
      get new_user_password_path
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /users/password/edit" do
    before do
      @token = Faker::Internet.password
      user.reset_password_token = Devise.token_generator.digest(self, :reset_password_token, @token)
      user.reset_password_sent_at = Time.now
      user.save!
    end

    it "パスワード再設定画面の表示に成功すること" do
      get "#{edit_user_password_path}?reset_password_token=#{@token}"
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end
end
