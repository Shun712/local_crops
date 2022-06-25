require 'rails_helper'

RSpec.describe SocialProfile, type: :model do
  let(:social_profile) { create(:social_profile) }

  context "バリデーション" do
    it "ユーザー、プロバイダー、uidがあれば有効な状態であること" do
      expect(social_profile).to be_valid
    end

    it "ユーザーがなければ無効な状態であること" do
      social_profile = build(:social_profile, user: nil)
      social_profile.valid?
      expect(social_profile.errors[:user]).to include('を入力してください')
    end

    it "プロバイダーがなければ無効な状態であること" do
      social_profile = build(:social_profile, provider: nil)
      social_profile.valid?
      expect(social_profile.errors[:provider]).to include('を入力してください')
    end
    
    it "uidがなければ無効な状態であること" do
      social_profile = build(:social_profile, uid: nil)
      social_profile.valid?
      expect(social_profile.errors[:uid]).to include('を入力してください')
    end
  end
end