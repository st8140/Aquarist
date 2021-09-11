require 'rails_helper'

RSpec.describe "Home", type: :system do
  before do
    visit "/"
  end

  describe "リンクの検証" do
    scenario "topリンクが正常であること" do
      expect(page).to have_link 'Aquarist', href: "/"
    end

    scenario "log_inリンクが正常であること" do
      expect(page).to have_link 'ログイン', href: new_user_session_path
    end

    scenario "新規登録リンクが正常であること" do
      expect(page).to have_link '新規登録', href: new_user_registration_path
    end
  end
end
