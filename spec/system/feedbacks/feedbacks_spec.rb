require 'rails_helper'

RSpec.describe 'Feedbacks', type: :system do

  describe 'お問い合わせ' do
    before do
      visit new_feedback_path
    end

    context '入力情報が正しいこと' do
      it '送信できること' do
        fill_in 'お名前', with: 'テストユーザー'
        fill_in 'メールアドレス', with: 'test@example.com'
        fill_in 'お問い合わせ内容', with: '作物登録方法を教えてください'
        click_button '送信'
        expect(current_path).to eq new_feedback_path
        expect(page).to have_content 'お問い合わせ内容を送信しました'
      end
    end

    context '入力情報が不正であること' do
      it '送信できないこと' do
        fill_in 'お名前', with: ' '
        fill_in 'メールアドレス', with: ' '
        fill_in 'お問い合わせ内容', with: ' '
        click_button '送信'
        expect(page).to have_content '送信に失敗しました'
      end
    end
  end
end
