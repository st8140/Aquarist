require 'rails_helper'

RSpec.describe "Home", type: :request do
  describe "GET home#top" do

    before do
      get root_path
    end

    it "正常なレスポンスが返ってくること" do
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end

    it "viewが正しく表示されること" do
      expect(response).to render_template :top
    end
  end
end
