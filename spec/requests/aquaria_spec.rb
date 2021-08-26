require 'rails_helper'

RSpec.describe "Aquaria", type: :request do
  let(:user_1) { create(:user) }
  let(:user_2) { create(:user) }
  let!(:aquarium_1) { create(:aquarium, user_id: user_1.id) }
  let!(:aquarium_2) { create(:aquarium, user_id: user_2.id) }

  before do
    sign_in user_1
    @like_1 = Like.create(
      user_id: user_1.id,
      aquarium_id: aquarium_2.id
    )

    @like_2 = Like.create(
      user_id: user_2.id,
      aquarium_id: aquarium_1.id
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
      expect(response.body).to include(aquarium_1.aquarium_introduction)
      expect(response.body).to include(aquarium_2.aquarium_introduction)
    end

    it "アクアリウム画像が正常に表示される" do
      expect(response.body).to include(aquarium_1.aquarium_image.to_s)
      expect(response.body).to include(aquarium_2.aquarium_image.to_s)
    end

    it "いいねが正常に表示される" do
      expect(response.body).to include(aquarium_1.likes.count.to_s)
      expect(response.body).to include(aquarium_2.likes.count.to_s)
    end
  end

  describe "GET /aquaria/:id" do
    before do
      get aquarium_path(aquarium_1)
      @comment = Comment.create(
        content: "test",
        user_id: user_2.id,
        aquarium_id: aquarium_1.id
      )
    end

    it "投稿詳細画面の表示に成功すること" do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "アクアリウム画像が正常に表示される" do
      expect(response.body).to include(aquarium_1.aquarium_image.to_s)
    end

    it "投稿内容が正常に表示される" do
      expect(response.body).to include(aquarium_1.aquarium_introduction)
    end

    it "名前が正常に表示される" do
      expect(response.body).to include(user_1.name)
    end

    it "プロフィール画像が正常に表示される" do
      expect(response.body).to include(user_1.user_image.to_s)
    end

    it "いいねが正常に表示される" do
      expect(response.body).to include(aquarium_1.likes.count.to_s)
    end

    it "コメントが正常に表示される" do
      expect(response.body).to include(@comment.content)
    end
  end
end
