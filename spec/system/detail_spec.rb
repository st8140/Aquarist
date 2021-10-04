require 'rails_helper'

RSpec.describe "User", type: :system do
  let(:user) { create(:user, name: 'John', introduction: 'john introduction') }
  let(:other_user) { create(:user, name: 'Doe', introduction: 'doe introduction') }
  let!(:aquarium) { create(:aquarium, aquarium_introduction: 'test introduction', user_id: user.id) }
  let!(:other_aquarium) { create(:aquarium, aquarium_introduction: 'other aquarium', user_id: other_user.id) }
  let!(:like) { create(:like, user_id: user.id, aquarium_id: other_aquarium.id) }
  let!(:liked) { create(:like, aquarium_id: aquarium.id) }
  let!(:comment) { create(:comment, aquarium_id: aquarium.id) }
  let!(:other_comment) { create(:comment, aquarium_id: other_aquarium.id) }
  let!(:following) { create(:relationship, following_id: user.id, follower_id: other_user.id) }
  let!(:follower) { create(:relationship, following_id: other_user.id, follower_id: user.id) }

  before do
    sign_in user
    visit detail_path(user)
  end

  describe ".user_profileの検証" do
    context "current_user == userの場合" do
      scenario "プロフィール編集リンクが表示される" do
        expect(page).to have_selector 'a', text: 'プロフィール編集'
      end
    end

    context "current_user != userの場合" do
      before do
        visit detail_path(other_user)
      end

      scenario "プロフィール編集リンクが表示されない" do
        expect(page).not_to have_selector 'a', text: 'プロフィール編集'
      end
    end
  end

  describe "#detailContentsの検証", js: true, vcr: true do
    context "投稿一覧" do
      before do
        click_on '投稿一覧'
      end
      
      scenario "投稿内容が正常に表示される" do
        expect(page).to have_content 'test introduction'
      end

      scenario "画像が正常に表示される" do
        expect(page).to have_css('.img-thumbnail')
      end

      scenario "いいねカウントが正常に表示される" do
        expect(page).to have_selector '.likes-count', text: '1'
      end

      scenario "コメントカウントが正常に表示される" do
        expect(page).to have_selector '.comment-count', text: '1'
      end
    end

    context "いいねした投稿" do
      before do
        click_on 'いいねした投稿'
      end

      scenario "投稿内容が正常に表示される" do
        expect(page).to have_content 'other aquarium'
      end

      scenario "画像が正常に表示される" do
        expect(page).to have_css('.img-thumbnail')
      end

      scenario "いいねカウントが正常に表示される" do
        expect(page).to have_selector '.likes-count', text: '1'
      end

      scenario "コメントカウントが正常に表示される" do
        expect(page). to have_selector '.comment-count', text: '1'
      end
    end
  
    context "フォロー" do
      before do
        click_on 'フォロー'
      end

      scenario "ユーザーアイコンが正常に表示される" do
        expect(page).to have_css('.follow-icon')
      end

      scenario "ユーザー名が正常に表示される" do
        expect(page).to have_content 'Doe'
      end

      scenario "自己紹介が正常に表示される" do
        expect(page).to have_content 'doe introduction'
      end

      scenario "フォローボタンが正常に表示される" do
        expect(page).to have_css('.follow-btn')
      end
    end

    context "フォロワー" do
      before do
        click_on 'フォロワー'
      end

      scenario "ユーザーアイコンが正常に表示される" do
        expect(page).to have_css('.follow-icon')
      end

      scenario "ユーザー名が正常に表示される" do
        expect(page).to have_content 'Doe'
      end

      scenario "自己紹介が正常に表示される" do
        expect(page).to have_content 'doe introduction'
      end

      scenario "フォローボタンが正常に表示される" do
        expect(page).to have_css('.follow-btn')
      end
    end
  end

  describe "ページネーションの検証", js: true , vcr: true do
    context "投稿数が16件以上の場合" do
      let!(:aquaria) { create_list(:aquarium, 15, user_id: user.id) }
      before do
        click_on '投稿一覧'
      end
      
      scenario "ページネーションが表示される" do
        expect(page).to have_css '.pagination'
      end

      scenario "次のページが表示される" do
        within '.pagination' do
          click_link '2'
        end
        within '.page-item.active' do
          expect(page).to have_selector '.page-link', text: '2'
        end
        expect(page).to have_css '.posts-box'
      end
  
      scenario "前のページに戻れる" do
        within '.pagination' do
          click_link '2'
          click_link '1'
        end
        within '.page-item.active' do
          expect(page).to have_selector '.page-link', text: '1'
        end
        expect(page).to have_css '.posts-box'
      end
    end

    context "いいねした投稿が16件以上の場合" do
      let!(:liked_aquaria) { create_list(:like, 15, user_id: user.id) }
      before do
        click_on 'いいねした投稿'
      end
      
      scenario "ページネーションが表示される" do
        expect(page).to have_css '.pagination'
      end

      scenario "次のページが表示される" do
        within '.pagination' do
          click_link '2'
        end
        within '.page-item.active' do
          expect(page).to have_selector '.page-link', text: '2'
        end
        expect(page).to have_css '.liked-aquaria-box'
      end
  
      scenario "前のページに戻れる" do
        within '.pagination' do
          click_link '2'
          click_link '1'
        end
        within '.page-item.active' do
          expect(page).to have_selector '.page-link', text: '1'
        end
        expect(page).to have_css '.liked-aquaria-box'
      end
    end

    context "フォロー数が16件以上の場合" do
      let!(:follow) { create_list(:relationship, 16, following_id: user.id) }
      before do
        click_on 'フォロー'
      end
      
      scenario "ページネーションが表示される" do
        expect(page).to have_css '.pagination'
      end

      scenario "次のページが表示される" do
        within '.pagination' do
          click_link '2'
        end
        within '.page-item.active' do
          expect(page).to have_selector '.page-link', text: '2'
        end
        expect(page).to have_css '.follows-box'
      end
  
      scenario "前のページに戻れる" do
        within '.pagination' do
          click_link '2'
          click_link '1'
        end
        within '.page-item.active' do
          expect(page).to have_selector '.page-link', text: '1'
        end
        expect(page).to have_css '.follows-box'
      end
    end

    context "フォロワー数が16件以上の場合" do
      let!(:followers) { create_list(:relationship, 16, follower_id: user.id) }
      before do
        click_on 'フォロワー'
      end
      
      scenario "ページネーションが表示される" do
        expect(page).to have_css '.pagination'
      end

      scenario "次のページが表示される" do
        within '.pagination' do
          click_link '2'
        end
        within '.page-item.active' do
          expect(page).to have_selector '.page-link', text: '2'
        end
        expect(page).to have_css '.followers-box'
      end
  
      scenario "前のページに戻れる" do
        within '.pagination' do
          click_link '2'
          click_link '1'
        end
        within '.page-item.active' do
          expect(page).to have_selector '.page-link', text: '1'
        end
        expect(page).to have_css '.followers-box'
      end
    end
  end

end
