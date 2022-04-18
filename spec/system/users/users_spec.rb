require 'rails_helper'

RSpec.describe 'ユーザー登録' do
  context '入力情報が正しい場合' do
    it '新規登録できること' do
      visit new_user_registration_path
      fill_in 'ユーザー名', with: 'テストユーザー'
      fill_in 'メールアドレス', with: 'test@example.com'
      fill_in 'パスワード(6文字以上)', with: 'password'
      fill_in 'パスワード確認', with: 'password'
      click_button 'アカウント登録'
      expect(page).to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください'
      visit current_path

    end
  end
end