require 'rails_helper'

RSpec.describe "Relationships", type: :system do
  let(:user_1) { create(:user, name: 'john') }
  let(:user_2) { create(:user, name: 'doe') }
  let(:user_3) { create(:user, name: 'john doe') }
  let!(:follower) { create(:relationship, following_id: user_3.id, follower_id: user_2.id) }
  let!(:following) { create(:relationship, following_id: user_2.id, follower_id: user_3.id) }

  before do
    sign_in user_1
    visit detail_path(user_2)
  end

  describe "フォロー、フォロー解除の検証", js: true, vcr: true do
    context "プロフィール画面から" do
      scenario "フォローができる" do
        find('.follow-btn').click
        expect(page).to have_selector '.unfollow', text: 'フォロー中'
        expect(user_1.followings.count).to eq(1)
        expect(user_2.followers.count).to eq(2)
      end

      scenario "フォロー解除ができる" do
        find('.follow-btn').click
        find('.unfollow').click
        expect(page).to have_selector '.follow-btn', text: 'フォロー'
        expect(user_1.followings.count).to eq(0)
        expect(user_2.followers.count).to eq(1)
      end
    end

    context "フォロー画面から" do
      before do
        find('.follow-link').click
      end

      scenario "フォローができる" do
        within '.follow-list' do
          find('.follow-btn').click
          expect(page).to have_selector '.unfollow', text: 'フォロー中'
          expect(user_1.followings.count).to eq(1)
          expect(user_3.followers.count).to eq(2)
        end
      end

      scenario "フォロー解除ができる" do
        within '.follow-list' do
          find('.follow-btn').click
          find('.unfollow').click
          expect(page).to have_selector '.follow', text: 'フォロー'
          expect(user_1.followings.count).to eq(0)
          expect(user_3.followers.count).to eq(1)
        end
      end
    end

    context "フォロワー画面から" do
      before do
        find('.follower-link').click
      end

      scenario "フォローができる" do
        within '.follow-list' do
          find('.follow-btn').click
          expect(page).to have_selector '.unfollow', text: 'フォロー中'
          expect(user_1.followings.count).to eq(1)
          expect(user_3.followers.count).to eq(2)
        end
      end

      scenario "フォロー解除ができる" do
        within '.follow-list' do
          find('.follow-btn').click
          find('.unfollow').click
          expect(page).to have_selector '.follow', text: 'フォロー'
          expect(user_1.followings.count).to eq(0)
          expect(user_3.followers.count).to eq(1)
        end
      end
    end
  end
end
