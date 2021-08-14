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

    it "プロフィール画像が正常に表示される" do
      expect(response.body).to include(user.user_image.to_s)
    end

    it "メールアドレスが正常に表示される" do
      expect(response.body).to include(user.email)
    end
  end

  describe "GET /registrations/user_posts" do
    before do
      sign_in user
      get users_posts_path(user)
    end

    it "投稿一覧画面の表示に成功すること" do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "投稿内容が正常に表示されること" do
      expect(response.body).to include(aquarium.aquarium_introduction)
    end

    it "画像が正常に表示されること" do
      expect(response.body).to include(aquarium.aquarium_image.to_s)
    end

    it "いいねが正常に表示される" do
      expect(response.body).to include(aquarium.likes.count.to_s)
    end
  end

  describe "GET /registrations/liked_aquaria " do
    before do
      sign_in user
      get users_liked_aquaria_path(user.id)
    end

    it "いいねした投稿画面の表示に成功すること" do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "名前が正常に表示される" do
      expect(response.body).to include(user.name)
    end

    it "プロフィール画像が正常に表示される" do
      expect(response.body).to include(user.user_image.to_s)
    end

    it "投稿内容が正常に表示される" do
      expect(response.body).to include(aquarium.aquarium_introduction)
    end

    it "アクアリウム画像が正常に表示される" do
      expect(response.body).to include(aquarium.aquarium_image.to_s)
    end

    it "いいねが正常に表示される" do
      expect(response.body).to include(aquarium.likes.count.to_s)
    end
  end

end
