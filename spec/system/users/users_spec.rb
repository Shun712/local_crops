require 'rails_helper'

RSpec.describe 'Users', type: :system do

  describe 'ユーザー登録' do
    before do
      visit new_user_registration_path
    end

    context '入力情報が正しい場合' do
      it '新規登録できること' do
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
        fill_in 'ユーザー名', with: ' '
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'パスワード(6文字以上)', with: 'password'
        fill_in 'パスワード確認', with: 'password'
        click_button 'アカウント登録'
        expect(page).to have_content 'お名前を入力してください'
      end
    end
  end

  describe 'プロフィールページ' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    before do
      sign_in user
      create_list(:crop, 10, user: user)
    end

    context 'ページレイアウト' do
      it 'ユーザー情報が表示されること' do
        # TODO フォロー数のテスト実装
        visit user_path(user)
        expect(page).to have_selector("img[src$='avatar.png']")
        expect(page).to have_content user.username
        expect(page).to have_selector("img[src$='test.png']")
        within ".page-title-overlap" do
          expect(page).to have_content 'プロフィール編集'
        end
      end

      it '他人のプロフィールページなら編集ボタンが表示されないこと' do
        visit user_path(other_user)
        within ".page-title-overlap" do
          expect(page).not_to have_content 'プロフィール編集'
        end
      end
    end
  end

  describe 'プロフィール編集ページ' do
    let!(:user) { create(:user) }
    before do
      sign_in user
      visit edit_mypage_account_path
    end

    context 'ページレイアウト' do
      it '入力部分に適切なラベルが表示されること' do
        expect(page).to have_content 'アバター画像'
        expect(page).to have_content 'お名前'
      end

      it'有効なプロフィール更新を行うと、更新成功フラッシュが表示されること' do
        attach_file 'user[avatar]', "#{Rails.root}/spec/fixture/files/avatar2.png"
        fill_in 'user[username]', with: '編集: テストユーザー'
        fill_in 'user[email]', with: 'edit@example.com'
        click_button '更新する'
        expect(current_path).to eq user_path(user)
        expect(page).to have_content 'プロフィールを更新しました'
        expect(page).to have_selector("img[src$='avatar2.png']")
        expect(user.reload.username).to eq '編集: テストユーザー'
      end

      it'無効なプロフィール更新をしようとすると、更新失敗フラッシュが表示されること' do
        fill_in 'user[username]', with: ' '
        click_button '更新する'
        expect(page).to have_content 'プロフィールの更新に失敗しました'
        expect(page).to have_content 'お名前を入力してください'
      end
    end
  end
end