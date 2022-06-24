require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  describe "使い方ページ" do
    before do
      visit root_path
    end

    it "使い方の文字列が存在することを確認" do
      expect(page).to have_content '使い方'
    end
  end

  describe "利用規約ページ" do
    before do
      visit terms_path
    end

    it "利用規約の文字列が存在することを確認" do
      expect(page).to have_content '利用規約'
    end
  end

  describe "プライバシーポリシーページ" do
    before do
      visit privacy_path
    end

    it "利用規約の文字列が存在することを確認" do
      expect(page).to have_content 'プライバシーポリシー'
    end
  end
end