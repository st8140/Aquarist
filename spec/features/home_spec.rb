require 'rails_helper'

RSpec.feature "Homes", type: :feature do
  background do
    visit root_path
  end

  feature "リンクの検証" do
    scenario "rootリンクが正常であること" do
      expect(page).to have_link 'Aquarist', href: root_path
    end
  end

  feature "ハンバーガーメニューの検証" do
    background do
      find("#hamburger").click
    end
    scenario "Log in 新規登録が正常に表示される"  do
      expect(page).to have_content("Log in")
      expect(page).to have_content("新規登録")
    end
  end
end
