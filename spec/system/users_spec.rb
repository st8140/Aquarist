require 'rails_helper'

RSpec.describe "User", type: :system do
  let!(:user) { create(:user, email: 'test1@example.com', password: 'testuser') }

  describe "ログインとログアウトの検証" do
    scenario "ログインに成功する" do
      visit new_user_session_path

      fill_in 'user_email', with: 'test1@example.com'
      fill_in 'user_password', with: 'testuser'
      click_button 'ログイン'
      expect(page).to have_content 'ログインしました'
    end

    scenario "ログインに失敗する" do
      visit new_user_session_path

      fill_in 'user_email', with: 'test1@example.com'
      fill_in 'user_password', with: 'testuser2'
      click_button 'ログイン'
      expect(page).to have_content 'パスワードが違います'
    end

    scenario "ログアウトする", js: true, vcr: true do 
      sign_in user
      visit aquaria_path

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
  
  describe "ユーザー編集、削除の検証", js: true, vcr: true do
    before do
      sign_in user
      visit edit_user_registration_path
    end
    
    scenario "名前の編集に成功する" do
      fill_in 'user_name', with: 'John Doe'
      fill_in 'user_current_password', with: 'testuser'
      click_on '更新'
      expect(page).to have_content 'アカウント情報を変更しました'
    end

    scenario "自己紹介の編集に成功する" do
      fill_in 'user_introduction', with: 'テストテスト'
      fill_in 'user_current_password', with: 'testuser'
      click_on '更新'
      expect(page).to have_content 'アカウント情報を変更しました'
    end

    scenario "パスワードの編集に成功する" do
      fill_in 'user_password', with: 'foobar'
      fill_in 'user_password_confirmation', with: 'foobar'
      fill_in 'user_current_password', with: 'testuser'
      click_on '更新'
      expect(page).to have_content 'アカウント情報を変更しました'
    end
    
    scenario "アカウント画像の編集に成功する" do
      attach_file 'アカウント画像', "#{Rails.root}/spec/fixtures/test.jpg"
      fill_in 'user_current_password', with: 'testuser'
      click_on '更新'
      expect(page).to have_content 'アカウント情報を変更しました'
    end

    scenario "カバー画像の編集に成功する" do
      attach_file 'カバー画像', "#{Rails.root}/spec/fixtures/test.jpg"
      fill_in 'user_current_password', with: 'testuser'
      click_on '更新'
      expect(page).to have_content 'アカウント情報を変更しました'
    end

    scenario "ユーザー編集に失敗する" do
      fill_in 'user_introduction', with: 'テストテスト'
      fill_in 'user_current_password', with: ''
      click_on '更新'
      expect(page).to have_content '現在のパスワードを入力してください'
    end

    scenario "ユーザーの削除" do
      click_on 'アカウント削除'
      page.accept_confirm
      expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
    end
  end
end
