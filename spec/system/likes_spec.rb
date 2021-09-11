require 'rails_helper'

RSpec.describe "Like", type: :system do
  let(:user_1) { create(:user) }
  let(:user_2) { create(:user) }
  let!(:aquarium) { create(:aquarium, user_id: user_2.id) }

  before do
    sign_in user_1
  end
  
  describe "投稿一覧画面の検証" do
    before do
      visit aquaria_path
    end

    scenario "新規いいねに成功する", js: true do
      find('.unlike-btn').click
      expect(page).to have_selector '.likes-count', text: '1'
    end
    
    scenario "いいねの取り消しに成功する", js: true do
      find('.unlike-btn').click
      find('.like-btn').click
      expect(page).to have_selector '.likes-count', text: '0'
    end
  end

  describe "投稿詳細画面の検証" do
    before do
      visit aquarium_path(aquarium.id)
    end

    scenario "新規いいねに成功する", js: true do
      find('.unlike-btn').click
      expect(page).to have_selector '.likes-count', text: '1'
    end
    
    scenario "いいねの取り消しに成功する", js: true do
      find('.unlike-btn').click
      find('.like-btn').click
      expect(page).to have_selector '.likes-count', text: '0'
    end
  end

  describe "アカウント投稿一覧画面の検証" do
    before do
      visit users_posts_path(user_2.id)
    end

    scenario "新規いいねに成功する", js: true do
      find('.unlike-btn').click
      expect(page).to have_selector '.likes-count', text: '1'
    end
    
    scenario "いいねの取り消しに成功する", js: true do
      find('.unlike-btn').click
      find('.like-btn').click
      expect(page).to have_selector '.likes-count', text: '0'
    end
  end

  describe "いいねした投稿画面の検証" do
    before do
      @like = Like.create(
        user_id: user_1.id,
        aquarium_id: aquarium.id
      )
      visit users_liked_aquaria_path(user_1.id)
    end
    
    scenario "いいねの取り消しに成功する", js: true do
      find('.like-btn').click
      expect(page).to_not have_css '.posts-table'
    end
  end





end
