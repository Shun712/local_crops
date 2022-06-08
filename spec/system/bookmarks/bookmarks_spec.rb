require 'rails_helper'

RSpec.describe 'Bookmarks', type: :system do
  describe 'ブックマーク' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:crop_by_user) { create(:crop, user: user) }
    let!(:crop_by_other_user) { create(:crop, user: other_user) }
    before do
      sign_in user
    end

    context '作物一覧ページ' do
      before do
        visit crops_path
      end

      context '他人の作物の場合' do
        it 'ブックマークできること' do
          expect(page).to have_css "#bookmark_area-#{crop_by_other_user.id}"
          expect { user.bookmark(crop_by_other_user) }.to change { Bookmark.count }.by(1)
        end

        it 'ブックマーク解除できること' do
          user.bookmark(crop_by_other_user)
          expect { user.unbookmark(crop_by_other_user) }.to change { Bookmark.count }.by(-1)
        end
      end

      context '自分の作物の場合' do
        it 'ブックマークが表示されないこと' do
          expect(page).not_to have_css "#bookmark_area-#{crop_by_user.id}"
        end
      end
    end

    context '作物詳細ページ' do
      context '他人の作物の場合' do
        it 'ブックマークできること' do
          visit crop_path(crop_by_other_user)
          expect(page).to have_css "#bookmark_area-#{crop_by_other_user.id}"
          expect { user.bookmark(crop_by_other_user) }.to change { Bookmark.count }.by(1)
        end

        it 'ブックマーク解除できること' do
          visit crop_path(crop_by_other_user)
          user.bookmark(crop_by_other_user)
          expect { user.unbookmark(crop_by_other_user) }.to change { Bookmark.count }.by(-1)
        end
      end

      context '自分の作物の場合' do
        it 'ブックマークが表示されないこと' do
          visit crop_path(crop_by_user)
          expect(page).not_to have_css "#bookmark_area-#{crop_by_user.id}"
        end
      end
    end

    context 'ブックマーク一覧ページ' do
      before do
        user.bookmark(crop_by_other_user)
        visit bookmarks_path
      end

      it 'ブックマークした作物が表示されること' do
        within "#crop-#{crop_by_other_user.id}" do
          expect(page).to have_content crop_by_other_user.name
          expect(page).to have_content crop_by_other_user.harvested_on
          expect(page).to have_content crop_by_other_user.user.username
        end
      end

      it 'ブックマーク解除した後、作物が表示されないこと' do
        visit crop_path(crop_by_other_user)
        expect { user.unbookmark(crop_by_other_user) }.to change { Bookmark.count }.by(-1)
        visit bookmarks_path
        expect(page).not_to have_css "#crop-#{crop_by_other_user.id}"
      end
    end
  end

end