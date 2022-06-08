require 'rails_helper'

RSpec.describe 'Relationships', type: :system do
  describe 'フォロー' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    before do
      sign_in user
    end

    context 'フォロー機能' do
      it 'フォローできること', js: true do
        visit user_path(other_user)
        expect {
          within "#follow-area-#{other_user.id}" do
            click_link 'フォローする'
            expect(page).to have_content 'フォロー解除'
          end
        }.to change(user.following, :count).by(1)
        expect(page).to have_content "1\nfollowers"
      end

      it 'フォロー解除できること', js: true do
        user.follow(other_user)
        visit user_path(other_user)
        expect {
          within "#follow-area-#{other_user.id}" do
            click_link 'フォロー解除'
            expect(page).to have_content 'フォローする'
          end
        }.to change(user.following, :count).by(-1)
        expect(page).to have_content "0\nfollowers"
      end
    end

    describe 'ページレイアウト' do
      context 'フォロー(following一覧)ページ' do
        before do
          create(:relationship, follower_id: user.id, followed_id: other_user.id)
          visit mypage_following_path
        end
        it 'フォロー中のユーザーが表示されていること' do
          expect(page).to have_content other_user.username
          expect(page).to have_link other_user.username, href: user_path(other_user)
          expect(page).to have_content 'フォロー解除'
        end
      end

      context 'フォロワー(followers一覧)ページ' do
        before do
          create(:relationship, follower_id: other_user.id, followed_id: user.id)
          visit mypage_follower_path
        end
        it 'フォロワーが表示されていること' do
          expect(page).to have_content other_user.username
          expect(page).to have_link other_user.username, href: user_path(other_user)
        end
      end
    end

    describe 'プロフィールページ' do
      context 'フォローしているユーザーの場合' do
        before do
          create(:relationship, follower_id: user.id, followed_id: other_user.id)
          visit user_path(other_user)
        end
        it '「フォロー解除」と表示されること' do
          expect(page).to have_content 'フォロー解除'
        end
      end

      context 'フォローしていないユーザーの場合' do
        before do
          visit user_path(other_user)
        end
        it '「フォロー」と表示されること' do
          expect(page).to have_content 'フォロー'
        end
      end

      context 'ページレイアウト' do
        before do
          create(:relationship, follower_id: user.id, followed_id: other_user.id)
          visit user_path(user)
        end
        it 'フォロー・フォロワー人数が表示されること' do
          expect(page).to have_content "#{user.followers.count}\nfollowers"
          expect(page).to have_content "#{user.following.count}\nfollowing"
        end
      end
    end
  end
end
