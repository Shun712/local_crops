require 'rails_helper'

RSpec.describe 'Notifications', type: :system do
  describe '通知' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:crop_by_user) { create(:crop, user: user) }
    let(:reservation_by_other_user) { create(:reservation, crop: crop_by_user, user: other_user) }
    let(:crop_by_other_user) { create(:crop, user: other_user) }
    before do
      sign_in user
    end

    context '作物が予約された場合' do
      before do
        reservation_by_other_user
      end

      it '通知が来ること' do
        visit mypage_notifications_path
        expect(page).to have_content "#{other_user.username}さんがあなたの作物を予約しました。"
      end
    end

    context '作物がブックマークされた場合' do
      before do
        other_user.bookmark(crop_by_user)
      end

      it '通知が来ること' do
        visit mypage_notifications_path
        expect(page).to have_content "#{other_user.username}さんがあなたの作物をブックマークしました。"
      end
    end

    context 'フォローされた場合' do
      before do
        other_user.follow(user)
      end

      it '通知が来ること' do
        visit mypage_notifications_path
        expect(page).to have_content "#{other_user.username}さんがあなたをフォローしました。"
      end
    end

    context 'チャットが来た場合' do
      it '通知が来ること' do
        sign_in other_user
        visit user_path(user)
        click_on 'チャット'
        fill_in 'メッセージ', with: 'こんにちは'
        click_button '送信'
        click_button 'メニュー'
        page.accept_confirm { find('.logout-button').click }
        sign_in user
        visit mypage_notifications_path
        expect(page).to have_content "#{other_user.username}さんがチャットルームにコメントしました。"
      end
    end

    context 'フォローしているユーザーが作物登録した場合' do
      before do
        user.follow(other_user)
        crop_by_other_user
      end

      it '通知が来ること' do
        visit mypage_notifications_path
        expect(page).to have_content "#{other_user.username}さんが作物を登録しました。"
      end
    end
  end
end
