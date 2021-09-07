require 'rails_helper'

RSpec.feature "Maps", type: :feature do
  given(:user) { create(:user) }

  background do
    sign_in user
    visit maps_path
  end

  scenario "近所のアクアショップが表示される", js: true do
    click_on '近所のアクアショップを探す'
    sleep 10
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_selector '.result-box'
  end

  scenario "住所指定でのショップが表示される", js: true do
    fill_in '住所を指定して探す', with: '東京都新宿区'
    find('#addressSearch').click
    expect(page).to have_selector '.result-box'
  end

end
