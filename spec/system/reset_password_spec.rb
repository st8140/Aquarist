require 'rails_helper'

RSpec.describe "User", type: :system do
  let!(:user) { create(:user, email: 'test1@example.com', password: 'testuser') }

  before do
    ActionMailer::Base.deliveries.clear
  end

  scenario "パスワード再設定メールの送信に成功する" do
    visit new_user_password_path

    fill_in 'user_email', with: 'test1@example.com'
    expect { click_on 'パスワードの再設定方法を送信する' }.to change { ActionMailer::Base.deliveries.size }.by(1)
    expect(page).to have_content 'パスワードの再設定について数分以内にメールでご連絡いたします。'
  end

  describe "パスワード再設定画面の検証" do
    shared_context '期限内のtoken作成' do
      before do
        @token = Faker::Internet.password
        user.reset_password_token = Devise.token_generator.digest(self, :reset_password_token, @token)
        user.reset_password_sent_at = Time.now
        user.save!
      end
    end

    shared_context '期限切れのtoken作成' do
      before do
        @token = Faker::Internet.password
        user.reset_password_token = Devise.token_generator.digest(self, :reset_password_token, @token)
        user.reset_password_sent_at = 2000-01-01
        user.save!
      end
    end

    context 'tokenを作成していない場合' do
      scenario "アクセスに失敗する" do
        visit "#{edit_user_password_path}?reset_password_token=#{@token}"
        expect(page).to have_content 'このページにはアクセスできません。パスワード再設定メールのリンクからアクセスされた場合には、URL をご確認ください。'
      end
    end

    context '期限内のtokenの場合' do
      include_context '期限内のtoken作成' do
        scenario "アクセスに成功する" do
          visit "#{edit_user_password_path}?reset_password_token=#{@token}"
          expect(page).to have_content '新しいパスワード (6 文字以上)'
        end
          
        scenario 'パスワード変更に成功する' do
          visit "#{edit_user_password_path}?reset_password_token=#{@token}"
          fill_in 'user_password', with: 'foobar'
          fill_in 'user_password_confirmation', with: 'foobar'
          click_on 'パスワードを変更する'
          expect(page).to have_content 'パスワードが正しく変更されました。'
        end
        
        scenario '空入力ではパスワードの変更に失敗する' do
          visit "#{edit_user_password_path}?reset_password_token=#{@token}"
          click_on 'パスワードを変更する'
          expect(page).to have_content 'パスワードを入力してください'
        end

        scenario '確認用パスワード未入力では変更に失敗する' do
          visit "#{edit_user_password_path}?reset_password_token=#{@token}"
          fill_in 'user_password', with: 'foobar'
          click_on 'パスワードを変更する'
          expect(page).to have_content 'パスワード（確認用）とパスワードの入力が一致しません'
        end
      end
    end

    context '期限切れのtokenの場合' do
      include_context '期限切れのtoken作成' do
        scenario 'パスワード変更に失敗する' do
          visit "#{edit_user_password_path}?reset_password_token=#{@token}"
          fill_in 'user_password', with: 'foobar'
          fill_in 'user_password_confirmation', with: 'foobar'
          click_on 'パスワードを変更する'
          expect(page).to have_content 'パスワードリセット用トークンの有効期限が切れました。新しくリクエストしてください。'
        end
      end
    end
  end
end
