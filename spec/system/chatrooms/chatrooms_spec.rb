require 'rails_helper'

RSpec.describe 'Chatrooms', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  before do
    sign_in user
  end

  context 'ページレイアウト' do
    it 'ユーザー詳細ページに「チャット」ボタンが存在すること' do
      visit user_path(other_user)
      expect(page).to have_content 'チャット'
    end
  end

  context 'チャット機能' do
    it '「チャット」ボタンを押すと、当該ユーザーとチャットルームに遷移すること' do
      visit user_path(other_user)
      click_link 'チャット'
      expect(current_path).to eq chatroom_path(Chatroom.first)
    end

    it 'テキストを入力しないで送信ボタンを押すとエラーメッセージが表示されること', js: true do
      visit user_path(other_user)
      click_link 'チャット'
      click_button '送信'
      sleep 0.5
      expect(page.driver.browser.switch_to.alert.text).to eq 'メッセージを入力してください'
    end

    it 'テキストを入力して送信ボタンを押すとメッセージが表示されること', js: true do
      visit user_path(other_user)
      click_link 'チャット'
      fill_in 'メッセージ', with: 'こんにちは'
      click_button '送信'
      expect(page).to have_content 'こんにちは'
    end

    it 'コメントの編集ボタンを押すとモーダルが表示されメッセージの更新ができること', js: true do
      visit user_path(other_user)
      click_link 'チャット'
      fill_in 'メッセージ', with: 'こんにちは'
      click_button '送信'
      expect(page).to have_content 'こんにちは'
      find('.edit-button').click
      within '#modal-container' do
        fill_in 'メッセージ', with: 'こんばんは'
        click_button '更新'
      end
      expect(page).to have_content 'こんばんは'
    end

    it 'コメントの削除ボタンを押すと確認ダイアログが出て「OK」を押すとコメントが削除されて画面から消えること', js: true do
      visit user_path(other_user)
      click_link 'チャット'
      fill_in 'メッセージ', with: 'こんにちは'
      click_button '送信'
      expect(page).to have_content 'こんにちは'
      page.accept_confirm { find('.delete-button').click }
      expect(page).not_to have_content 'こんにちは'
    end
  end
end