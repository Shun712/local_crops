require 'rails_helper'

RSpec.describe 'Crops', type: :system do
  describe '作物登録' do
    let!(:user) { create(:user) }
    let!(:crop) { create(:crop, user: user) }
    before do
      sign_in user
      visit new_crop_path
    end

    context '入力情報が正しい場合' do
      it '新規登録できること' do
        attach_file 'crop[picture]', "#{Rails.root}/spec/fixture/files/test.png"
        fill_in '作物名', with: 'トマト'
        fill_in '説明', with: 'テスト説明'
        select_date('2022-5-4', from: '収穫日')
        click_button '登録する'
        expect(current_path).to eq crops_path
        expect(page).to have_content '作物を登録しました'
      end
    end

    context '入力情報に間違いがある場合' do
      it '新規登録できないこと' do
        attach_file 'crop[picture]', "#{Rails.root}/spec/fixture/files/test.png"
        fill_in '作物名', with: ' '
        fill_in '説明', with: ' '
        select_date('2022-5-4', from: '収穫日')
        click_button '登録する'
        expect(page).to have_content '登録に失敗しました'
      end
    end
  end

  describe '作物一覧ページ' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:crop) { create(:crop, user: user) }
    let!(:crop_by_other_user) { create(:crop, user: other_user) }
    before do
      sign_in user
      visit crops_path
    end

    context 'ページレイアウト' do
      it '自分の作物には編集、削除ボタンが表示されること' do
        within "#crop-#{crop.id}" do
          expect(page).to have_css '.edit-button'
          expect(page).to have_css '.delete-button'
        end
      end

      it '他人の作物には編集、削除ボタンが表示されないこと' do
        within "#crop-#{crop_by_other_user.id}" do
          expect(page).not_to have_css '.edit-button'
          expect(page).not_to have_css '.delete-button'
          expect(page).to have_css '.reserve-button'
        end
      end
    end
  end

  describe '作物詳細ページ' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:crop) { create(:crop, user: user) }
    let!(:crop_by_other_user) { create(:crop, user: other_user) }
    before do
      sign_in user
      visit crop_path(crop)
    end

    context 'ページレイアウト' do
      it '正しい作物情報が表示されること' do
        expect(page).to have_selector("img[src$='test.png']")
        expect(page).to have_content crop.name
        expect(page).to have_content crop.description
        expect(page).to have_content crop.harvested_on
      end

      it '自分の作物には編集、削除ボタンが表示されること' do
        expect(page).to have_css '.edit-button'
        expect(page).to have_css '.delete-button'
      end

      it '他人の作物には編集、削除ボタンが表示されないこと' do
        visit crop_path(crop_by_other_user)
        expect(page).not_to have_css '.edit-button'
        expect(page).not_to have_css '.delete-button'
        expect(page).to have_css '.reserve-button'
      end
    end

    context "作物の削除", js: true do
      it '削除成功のフラッシュが表示されること' do
        page.accept_confirm { find('.delete-button').click }
        expect(page).to have_content '作物を削除しました'
      end
    end
  end

  describe '作物編集ページ' do
    let!(:user) { create(:user) }
    let!(:crop) { create(:crop, user: user) }
    before do
      sign_in user
      visit crop_path(crop)
      click_link '編集'
    end

    context 'ページレイアウト' do
      it '入力部分に適切なラベルが表示されること' do
        expect(page).to have_content '画像'
        expect(page).to have_content '作物名'
        expect(page).to have_content '説明'
        expect(page).to have_content '収穫日'
      end
    end

    context '入力情報が正しい場合' do
      it '更新処理ができること' do
        attach_file 'crop[picture]', "#{Rails.root}/spec/fixture/files/test2.png"
        fill_in '作物名', with: '編集:トマト'
        fill_in '説明', with: '編集:説明'
        select_date('2022-5-5', from: '収穫日')
        click_button '更新する'
        expect(current_path).to eq crops_path
        expect(page).to have_content '作物を更新しました'
        expect(page).to have_selector("img[src$='test2.png']")
        expect(page).to have_content '編集:トマト'
        expect(page).to have_content '編集:説明'
        expect(page).to have_content '2022-05-05'
      end
    end

    context '入力情報に間違いがある場合' do
      it '更新処理ができないこと' do
        attach_file 'crop[picture]', "#{Rails.root}/spec/fixture/files/test2.png"
        fill_in '作物名', with: ' '
        fill_in '説明', with: ' '
        select_date('2022-5-5', from: '収穫日')
        click_button '更新する'
        expect(page).to have_content '作物の更新に失敗しました'
      end
    end
  end
end
