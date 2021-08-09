require 'rails_helper'

RSpec.feature "Likes", type: :feature do
  given(:image_path) { File.join(Rails.root, 'spec/fixtures/test.jpg') }
  given(:image) { Rack::Test::UploadedFile.new(image_path) }
  given(:user_1) { create(:user) }
  given(:user_2) { create(:user) }

  background do
    sign_in user_1
    @aquarium = Aquarium.create(
      aquarium_introduction: "test",
      aquarium_image: image,
      user_id: user_2.id
    )
  end
  
  feature "投稿一覧画面の検証" do
    background do
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

  feature "投稿詳細画面の検証" do
    background do
      visit aquarium_path(@aquarium.id)
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

  feature "アカウント投稿一覧画面の検証" do
    background do
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

  feature "いいねした投稿画面の検証" do
    background do
      @like = Like.create(
        user_id: user_1.id,
        aquarium_id: @aquarium.id
      )
      visit users_liked_aquaria_path(user_1.id)

    end
    
    scenario "いいねの取り消しに成功する", js: true do
      find('.like-btn').click
      expect(page).to_not have_css '.posts-table'
    end
  end





end
