require 'rails_helper'

RSpec.describe 'Chatrooms', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:crop_by_user) { create(:crop, user: user) }
  let!(:reservation) { create(:reservation, crop: crop_by_user, user: other_user) }
  before do
    sign_in user
  end

  describe 'ページレイアウト' do
    context 'ユーザー詳細ページ' do
      before do
        visit user_path(other_user)
      end
      it 'ユーザー詳細ページに「チャット」ボタンが存在すること' do
        expect(page).to have_content 'チャット'
      end

      it '予約一覧がモーダルで確認できること', js: true do
        click_on 'チャット'
        find('.index-button').click
        within "#reservation-#{reservation.id}" do
          expect(page).to have_content reservation.crop.name
          expect(page).to have_content reservation.received_at.strftime('%Y/%m/%d')
          expect(page).to have_content reservation.received_at.strftime('%H:%M')
        end
      end
    end

    context 'チャット一覧ページ' do
      it 'チャットルームが表示されること' do
        visit chatrooms_path
        expect(current_path).to eq chatrooms_path
      end
    end
  end

  context 'チャット機能' do
    it '「チャット」ボタンを押すと、当該ユーザーとチャットルームに遷移すること' do
      visit user_path(other_user)
      click_on 'チャット'
      expect(current_path).to eq chatroom_path(Chatroom.first)
    end

    it 'テキストを入力して送信ボタンを押すとメッセージが表示されること', js: true do
      visit user_path(other_user)
      click_on 'チャット'
      fill_in 'メッセージ', with: 'こんにちは'
      click_button '送信'
      expect(page).to have_content 'こんにちは'
    end

    it 'コメントの編集ボタンを押すとモーダルが表示されメッセージの更新ができること', js: true do
      visit user_path(other_user)
      click_on 'チャット'
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
      click_on 'チャット'
      fill_in 'メッセージ', with: 'こんにちは'
      click_button '送信'
      expect(page).to have_content 'こんにちは'
      page.accept_confirm { find('.delete-button').click }
      expect(page).not_to have_content 'こんにちは'
    end
  end
end