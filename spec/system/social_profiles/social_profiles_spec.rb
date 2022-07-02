require 'rails_helper'

RSpec.describe 'Social_Profiles', type: :system do

  describe 'SNS認証登録' do
    before do
      OmniAuth.config.mock_auth[:line] = nil
      OmniAuth.config.mock_auth[:twitter] = nil
      visit new_user_registration_path
    end

    context 'LINE認証ができる場合' do
      it '新規登録でき以降はログインできること' do
        Rails.application.env_config['omniauth.auth'] = line_mock
        expect(page).not_to have_content('ログアウト')
        find_link(href: '/users/auth/line').click
        expect(page).to have_content('Line アカウントによる認証に成功しました。')
        expect(current_path).to eq edit_account_path
        fill_in 'user[address]', with: '埼玉県吉川市上内川'
        click_button '更新する'
        click_on('ログアウト')
        visit new_user_session_path
        find_link(href: '/users/auth/line').click
        expect(page).to have_content('ログインしました。')
        expect(current_path).to eq crops_path
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
      it '新規登録でき以降はログインできること' do
        Rails.application.env_config['omniauth.auth'] = twitter_mock
        expect(page).not_to have_content('ログアウト')
        find_link(href: '/users/auth/twitter').click
        expect(page).to have_content('Twitter アカウントによる認証に成功しました。')
        expect(current_path).to eq edit_account_path
        fill_in 'user[address]', with: '埼玉県吉川市上内川'
        click_button '更新する'
        click_on('ログアウト')
        visit new_user_session_path
        find_link(href: '/users/auth/twitter').click
        expect(page).to have_content('ログインしました。')
        expect(current_path).to eq crops_path
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