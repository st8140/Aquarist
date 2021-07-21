require 'rails_helper'

RSpec.feature "Users", type: :feature do

  feature "ログインとログアウトの検証" do
    background do
      @user = create(:user)
    end

    scenario "ログインに成功する" do
      visit new_user_session_path

      fill_in 'メールアドレス', with: 'test1@example.com'
      fill_in 'パスワード', with: 'testuser'
      click_button 'ログイン'
      expect(page).to have_content 'ログインしました'
    end

    scenario "ログインに失敗する" do
      visit new_user_session_path

      fill_in 'メールアドレス', with: 'test2@example.com'
      fill_in 'パスワード', with: 'testuser2'
      click_button 'ログイン'
      expect(page).to have_content 'パスワードが違います'
    end

    scenario "ログアウトする", js: true do 
      visit new_user_session_path

      fill_in 'メールアドレス', with: 'test3@example.com'
      fill_in 'パスワード', with: 'testuser'
      click_button 'ログイン'
      find("#current_user").click
      click_on 'ログアウト'

      expect(page).to have_content 'ログアウトしました'
    end
  end

  scenario "新規ユーザーの作成" do
    visit new_user_registration_path

    fill_in 'name_field', with: 'john doe'
    fill_in 'email_field', with: 'johndoe@example.com'
    fill_in 'password_field', with: 'foobar'
    fill_in 'password_confirmation_field', with: 'foobar'
    click_on 'アカウント登録'

    expect(page).to have_content 'アカウント登録が完了しました'

  end
end
