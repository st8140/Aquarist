require 'rails_helper'

RSpec.describe "Aquaria", type: :request do
  let(:user_1) { create(:user) }
  let(:user_2) { create(:user) }
  let(:image_path) { File.join(Rails.root, 'app/assets/images/no_image.jpg') }
  let(:image) { Rack::Test::UploadedFile.new(image_path) }

  before do
    sign_in user_1
    @aquarium_1 = Aquarium.create(
      aquarium_introduction: "test_1",
      aquarium_image: image,
      user_id: user_1.id
    )

    @aquarium_2 = Aquarium.create(
      aquarium_introduction: "test_2",
      aquarium_image: image,
      user_id: user_2.id
    )
  end

  describe "GET /aquaria" do
    before do
      get aquaria_path
    end

    it "投稿一覧画面の表示に成功すること" do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "名前が正常に表示される" do
      expect(response.body).to include(user_1.name)
      expect(response.body).to include(user_2.name)
    end

    it "プロフィール画像が正常に表示される" do
      expect(response.body).to include(user_1.user_image.to_s)
      expect(response.body).to include(user_2.user_image.to_s)
    end

    it "投稿内容が正常に表示される" do
      expect(response.body).to include(@aquarium_1.aquarium_introduction)
      expect(response.body).to include(@aquarium_2.aquarium_introduction)
    end

    it "アクアリウム画像が正常に表示される" do
      expect(response.body).to include(@aquarium_1.aquarium_image.to_s)
      expect(response.body).to include(@aquarium_2.aquarium_image.to_s)
    end
  end

  describe "GET /aquaria/:id" do
    before do
      get aquaria_path(user_1)
    end

    it "投稿詳細画面の表示に成功すること" do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "アクアリウム画像が正常に表示される" do
      expect(response.body).to include(@aquarium_1.aquarium_image.to_s)
    end

    it "投稿内容が正常に表示される" do
      expect(response.body).to include(@aquarium_1.aquarium_introduction)
    end

    it "名前が正常に表示される" do
      expect(response.body).to include(user_1.name)
    end

    it "プロフィール画像が正常に表示される" do
      expect(response.body).to include(user_1.user_image.to_s)
    end
  end

end
