require 'rails_helper'

RSpec.feature "Comments", type: :feature do
  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:aquarium) { create(:aquarium, user_id: user.id) }
  given!(:comment) { create(:comment,  content: 'テストコメント', aquarium_id: aquarium.id, user_id: user.id) }
  given!(:other_comment) {
    |i| create_list(:comment, 2, content: "test comment_#{i}", aquarium_id: aquarium.id)
  }

  background do
    sign_in user
    visit aquarium_path(aquarium, anchor: "comment-form")
  end

  feature "コメント新規投稿の検証" do
    scenario "新規投稿に成功する", js: true do
      fill_in 'comment_content', with: 'テスト'
      click_on 'コメントを投稿'
      expect {
        expect(page).to change(Comment, :count).by(1)
      }
    end

    scenario "新規投稿に失敗する", js: true do
      fill_in 'comment_content', with: ''
      click_on 'コメントを投稿'
      expect(page).to have_content 'コメントを入力してください'
    end
  end
  
  feature "コメント削除の検証" do
    scenario "削除に成功する", js: true do
      click_on 'もっと見る....'
      find('#comment-delete-btn-cl').click
      expect {
        page.accept_confirm "本当にコメントを削除しますか？"
        expect(page).to change(Comment, :count).by(-1)
      }
    end

    context "current_user.id != comment.user_idの場合" do
      background do
        sign_in other_user
      end
      scenario "削除リンクが表示されない" do
        click_on 'もっと見る....'
        expect(page).to_not have_css('#comment_delete_btn')
      end
    end
  end


  feature "コメント表示の検証" do
    context "3件以上コメントがある場合" do

      scenario "表示ボタンを押さなければ表示されない", js: true do
        expect(page).to_not have_content 'テストコメント'
      end

      scenario "表示ボタンを押すと表示される", js: true do
        click_on 'もっと見る....'
        expect(page).to have_content 'テストコメント'
      end
    end
  end

end
