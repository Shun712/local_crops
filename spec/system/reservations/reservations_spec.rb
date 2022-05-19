require 'rails_helper'

RSpec.describe 'Reservations', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:crop_by_user) { create(:crop, user: user) }
  let!(:crop_by_other_user) { create(:crop, user: other_user) }
  let!(:reservation) { create(:reservation, user: user) }
  let!(:reservation_by_other_user) { create(:reservation, crop: crop_by_user, user: other_user) }
  before do
    sign_in user
  end

  describe '予約登録', js: true do
    context '作物一覧ページ' do
      it '新規登録できること' do
        visit root_path
        within "#crop-#{crop_by_other_user.id}" do
          expect(page).to have_css '.reserve-button'
          click_link '予約する'
        end
        fill_in '受取日時', with: '002022-5-5-15:00T00:16:12'
        click_on '確定'
        expect(page).to have_content '予約を登録しました'
        expect(current_path).to eq root_path
      end
    end

    context '作物詳細ページ' do
      it '新規登録できること' do
        visit crop_path(crop_by_other_user)
        expect(page).to have_css '.reserve-button'
        click_link '予約する'
        fill_in '受取日時', with: '002022-5-5-15:00T00:16:12'
        click_on '確定'
        expect(page).to have_content '予約を登録しました'
        expect(current_path).to eq root_path
      end
    end
  end

  describe '予約一覧ページ' do
    before do
      visit reservations_path
    end

    context 'ページレイアウト' do
      it '予約した作物がリストに表示されること' do
        create_list(:reservation, 30, user: user)
        visit reservations_path
        expect(page.all(".align-middle").count).to eq 12
        expect(page).to have_css('.page-link')
        expect { find_link('2', rel = "next").click }
        expect { find_link('1', rel = "prev").click }
        within "#reservation-#{reservation.id}" do
          expect(page).to have_content reservation.crop.name
          expect(page).to have_content reservation.crop.user.username
          expect(page).to have_content reservation.received_at.strftime('%Y/%m/%d')
          expect(page).to have_content reservation.received_at.strftime('%H:%M')
        end
      end

      it '他人の作物を予約した場合は、取引欄が「受取」と表示されること' do
        within "#reservation-#{reservation.id}" do
          expect(page).to have_content '受取'
        end
      end

      it '自分の作物が予約された場合は、取引欄が「引渡」と表示されること' do
        within "#reservation-#{reservation_by_other_user.id}" do
          expect(page).to have_content '引渡'
        end
      end

      it '生産者は予約を取消できること', js: true do
        within "#reservation-#{reservation_by_other_user.id}" do
          page.accept_confirm { find('.delete-button').click }
        end
        expect(page).to have_content '予約を取消しました'
      end

      it '消費者は予約を取消できること', js: true do
        within "#reservation-#{reservation.id}" do
          page.accept_confirm { find('.delete-button').click }
        end
        expect(page).to have_content '予約を取消しました'
      end
    end
  end
end
