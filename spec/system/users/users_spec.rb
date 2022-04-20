require 'rails_helper'

RSpec.describe 'Users', type: :system do

  describe 'ユーザー登録' do
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
        expect(page).not_to have_content '本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください'
      end
    end

    context '入力情報に間違いがある場合' do
      it '新規登録できないこと' do
        visit new_user_registration_path
        fill_in 'ユーザー名', with: ' '
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード(6文字以上)', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button 'アカウント登録'
        expect(page).to have_content 'ユーザー名を入力してください'
      end
    end
  end

  describe 'SNS認証登録' do
    before do
      OmniAuth.config.mock_auth[:line] = nil
      OmniAuth.config.mock_auth[:twitter] = nil
      visit new_user_session_path
    end

    context 'LINE認証ができる場合' do
      it '新規登録し、以降はログインできること' do
        Rails.application.env_config['omniauth.auth'] = line_mock
        expect(page).not_to have_content('ログアウト')
        find_link(href: '/users/auth/line').click
        expect(page).to have_content('Line アカウントによる認証に成功しました。')
        visit root_path
        click_on('ログアウト')
        find_link(href: '/users/auth/line').click
        expect(page).to have_content('ログインしました。')
      end
    end

    context 'LINE認証ができない場合' do
      it '新規登録できないこと' do
        Rails.application.env_config['omniauth.auth'] = line_invalid_mock
        expect(page).not_to have_content('ログアウト')
        find_link(href: '/users/auth/line').click
        expect(page).to have_content('Line アカウントによる認証に失敗しました。')
      end
    end

    context 'Twitter認証ができる場合' do
      it '新規登録でき、以降はログインできること' do
        Rails.application.env_config['omniauth.auth'] = twitter_mock
        expect(page).not_to have_content('ログアウト')
        find_link(href: '/users/auth/twitter').click
        expect(page).to have_content('Twitter アカウントによる認証に成功しました。')
        visit root_path
        click_on('ログアウト')
        find_link(href: '/users/auth/twitter').click
        expect(page).to have_content('ログインしました。')
      end
    end

    context 'Twitter認証ができない場合' do
      it '新規登録できないこと' do
        Rails.application.env_config['omniauth.auth'] = twitter_invalid_mock
        expect(page).not_to have_content('ログアウト')
        find_link(href: '/users/auth/twitter').click
        expect(page).to have_content('Twitter アカウントによる認証に失敗しました。')
      end
    end
  end
end