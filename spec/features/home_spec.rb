require 'rails_helper'

RSpec.feature "Homes", type: :feature do
  background do
    visit "/"
  end

  feature "リンクの検証" do
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

  feature "ハンバーガーメニューの検証" do
    background do
      find("#hamburger").click
    end
    scenario "ログイン,新規登録が正常に表示される"  do
      expect(page).to have_content("ログイン")
      expect(page).to have_content("新規登録")
    end
  end
end
