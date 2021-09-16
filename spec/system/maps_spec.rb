require 'rails_helper'

RSpec.describe "Maps", type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
    visit maps_path
  end

  context "map表示の検証", js: true do
    scenario "ショップが表示される", vcr: true do
      fill_in '住所を指定して探す', with: '東京都新宿区'
      find('#addressSearch').click
      expect(page).to have_selector '.result-box'
    end
  
    scenario "ピンをクリックするとinfowindow が表示されること", vcr: true do
      fill_in '住所を指定して探す', with: '東京都新宿区'
      find('#addressSearch').click
      pin = all("div#target area")[1]
      pin.click
      expect(page).to have_css "div.gm-style-iw"
    end

  end

end
