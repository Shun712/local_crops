require 'rails_helper'

RSpec.describe 'UserSessions', type: :system do
  let(:user) { create(:user) }

  describe 'メールアドレスとパスワードでログイン' do
    before do
      visit new_user_session_path
    end
    context '認証情報が正しいこと' do
      it 'ログインできること' do
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'testpassword'
        click_button 'ログイン'
        expect(current_path).to eq crops_path
        expect(page).to have_content('ログインしました。')
      end
    end

    context '認証情報に誤りがあること' do
      it 'ログインできないこと' do
        fill_in 'メールアドレス', with: user.email
        fill_in 'パスワード', with: 'invalidpassword'
        click_button 'ログイン'
        expect(current_path).to eq new_user_session_path
        expect(page).to have_content('メールアドレスまたはパスワードが違います。')
      end
    end
  end

  describe 'ログアウト' do
    before do
      sign_in user
      visit crops_path
    end
    it 'ログアウトできること' do
      click_on('ログアウト')
      expect(current_path).to eq new_user_session_path
      expect(page).to have_content('ログアウトしました。')
    end
  end
end