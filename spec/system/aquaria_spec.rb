require 'rails_helper'

RSpec.describe "Aquarium", type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let!(:aquarium) { create(:aquarium, user_id: user.id, aquarium_introduction: "this is a test introduction") }

  before do
    sign_in user
    visit aquaria_path
  end

  describe "投稿一覧ページ、リンク先の検証" do
    scenario "アカウント詳細リンクが正常であること" do
      expect(page).to have_link user.name, href: detail_path(user)
    end

    scenario "新規投稿リンクが正常であること" do
      expect(page).to have_link '新規投稿', href: new_aquarium_path
    end

    scenario "投稿詳細リンクが正常であること" do
      expect(page).to have_link 'aquarium_image', href: aquarium_path(aquarium)
    end

    scenario "ショップ検索リンクが正常であること" do
      expect(page).to have_link 'ショップ検索', href: maps_path
    end
  end

  describe "投稿詳細ページ、リンク先の検証" do
    let(:other_user) { create(:user, name: 'other_user') }
    let!(:like) { create(:like, aquarium_id: aquarium.id, user_id: other_user.id) }
    before do
      visit aquarium_path(aquarium)
    end

    scenario "アカウント詳細リンクが正常であること" do
      expect(page).to have_link user.name, href: detail_path(user)
    end

    scenario "いいねしたユーザーmodalが表示される", js: true do
      find('.like-user').click
      expect(page).to have_content('other_user')
    end
  end

  describe "新規投稿の検証" do
    scenario "新規投稿に成功する", js: true do
      click_on '新規投稿'
      fill_in 'aquarium_aquarium_introduction', with: 'テスト'
      attach_file '画像', "#{Rails.root}/spec/fixtures/test.jpg"
      click_button '投稿する'
      expect {
        expect(page).to change(Aquarium, :count).by(1)
      }
    end
  
    scenario "新規投稿に失敗する", js: true do
      click_on '新規投稿'
      click_button '投稿する'
      expect(page).to have_content '投稿内容を入力してください'
      expect(page).to have_content '画像を選択してください'
    end
  end

  describe "投稿編集の検証" do
    before do
      click_on 'aquarium_image'
    end

    scenario "更新に成功する", js: true do
      find('#edit-button').click
      fill_in 'message-text', with: 'テスト'
      attach_file '画像', "#{Rails.root}/spec/fixtures/test.jpg"
      click_button '更新する'
      expect(page).to have_content '投稿を更新しました'
    end
  
    scenario "更新に失敗する", js: true do
      find('#edit-button').click
      fill_in 'message-text', with: nil
      click_button '更新する'
      expect(page).to have_content '投稿内容を入力してください'
    end
  end

  describe "投稿削除の検証" do
    before do
      visit aquarium_path(aquarium)
    end

    scenario "削除に成功する", js:true do
      find('#delete-button').click
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content '投稿を削除しました'
    end
  end

  describe "current_user.id != aquarium.user_idの場合" do
    before do
      sign_in other_user
      visit aquarium_path(aquarium)
    end

    scenario "編集リンクが表示されない" do
      expect(page).to_not have_css '#edit-button'
    end

    scenario "削除リンクが表示されない" do
      expect(page).to_not have_css '#delete-button'
    end
  end

  describe "投稿検索の検証" do
    let!(:other_aquarium) { create(:aquarium, user_id: user.id, aquarium_introduction: "other introduction") }

    scenario "あいまい検索に成功する", js: true do
      fill_in 'aquarium-search', with: 'this'
      find('#aquarium-search').native.send_key(:enter)
      expect(page).to have_content 'this is a test introduction'
    end

    scenario "フルワードでの検索に成功する", js: true do
      fill_in 'aquarium-search', with: 'other introduction'
      find('#aquarium-search').native.send_key(:enter)
      expect(page).to have_content 'other introduction'
    end
  end

end
