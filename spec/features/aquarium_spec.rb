require 'rails_helper'

RSpec.feature "Aquaria", type: :feature do
  include Devise::Test::IntegrationHelpers
  
  given(:user) { create(:user) }
  given(:image_path) { File.join(Rails.root, 'app/assets/images/no_image.jpg') }
  given(:image) { Rack::Test::UploadedFile.new(image_path) }
  
  background do
    @aquarium = Aquarium.create(
      aquarium_introduction: "test",
      aquarium_image: image,
      user_id: user.id
    )

    sign_in user
    visit aquaria_path

  end

  feature "新規投稿の検証" do

    scenario "新規投稿に成功する", js: true do
      click_on '新規投稿'
      fill_in 'aquarium_aquarium_introduction', with: 'テスト'
      attach_file '画像', "#{Rails.root}/app/assets/images/suirenbachi.jpg"
      click_button '投稿する'
      expect(page).to have_content 'アクアリウムを投稿しました'
    end
  
    scenario "新規投稿に失敗する", js: true do
      click_on '新規投稿'
      click_button '投稿する'
      expect(page).to have_content '投稿内容を入力してください'
      expect(page).to have_content '画像を選択してください'
    end
  end

  feature "投稿編集の検証" do
    background do
      click_on 'aquarium_image'
    end

    scenario "更新に成功する", js: true do
      find('#edit-button').click
      fill_in 'message-text', with: 'テスト'
      attach_file '画像', "#{Rails.root}/app/assets/images/suirenbachi.jpg"
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





end
