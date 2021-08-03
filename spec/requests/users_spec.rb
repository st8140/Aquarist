require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:image_path) { File.join(Rails.root, 'app/assets/images/no_image.jpg') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }

  before do
    @aquarium = Aquarium.create(
      aquarium_introduction: "test",
      aquarium_image: image,
      user_id: user.id
    )
  end

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
      get user_posts_path(user)
    end

    it "投稿一覧画面の表示に成功すること" do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "投稿内容が正常に表示されること" do
      expect(response.body).to include(@aquarium.aquarium_introduction)
    end

    it "画像が正常に表示されること" do
      expect(response.body).to include(@aquarium.aquarium_image.to_s)
    end
  end

end
