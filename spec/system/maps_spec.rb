require 'rails_helper'

RSpec.describe "Map", type: :system do
  let(:user) { create(:user) }
  
  before do
    sign_in user
    visit maps_path
  end

  scenario "住所指定でのショップが表示される", js: true do
    fill_in '住所を指定して探す', with: '東京都新宿区'
    find('#addressSearch').click
    expect(page).to have_selector '.result-box'
  end

end
