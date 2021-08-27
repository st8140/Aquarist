require 'rails_helper'

RSpec.describe "Maps", type: :request do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe "GET /index" do
    before do
      get maps_path
    end

    it "ショップ検索画面の表示に成功すること" do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end
end
