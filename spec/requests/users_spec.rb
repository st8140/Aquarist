require 'rails_helper'

RSpec.describe "Users", type: :request do
  
  describe "GET /registrations/new" do
    it "正常なレスポンスが返ってくること" do
      get new_user_registration_path
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /session/new" do
    it "正常なレスポンスが返ってくること" do
      get new_user_session_path
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

end
