# == Schema Information
#
# Table name: crops
#
#  id           :bigint           not null, primary key
#  description  :text(65535)
#  harvested_on :date
#  name         :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_crops_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Crop, type: :model do
  let!(:crop) { create(:crop) }
  let!(:crop_yesterday) { create(:crop, :yesterday) }
  let!(:crop_two_days_ago) { create(:crop, :two_days_ago) }
  let!(:crop_three_days_ago) { create(:crop, :three_days_ago) }

  context 'バリデーション' do
    it "有効な状態であること" do
      expect(crop).to be_valid
    end

    it "名前がなければ無効な状態であること" do
      crop = build(:crop, name: nil)
      crop.valid?
      expect(crop.errors[:name]).to include("を入力してください")
    end

    it "説明が1000文字以内であること" do
      crop = build(:crop, description: "a" * 1001)
      crop.valid?
      expect(crop.errors[:description]).to include("は1000文字以内で入力してください")
    end

    it "収穫日がなければ無効な状態であること" do
      crop = build(:crop, harvested_on: nil)
      crop.valid?
      expect(crop.errors[:harvested_on]).to include("を入力してください")
    end

    it "画像がなければ無効な状態であること" do
      crop = build(:crop)
      crop.picture = nil
      crop.valid?
      expect(crop.errors[:picture]).to include("ファイルを添付してください")
    end
  end

  context "並び順" do
    it "最も最近の作物が最初の作物になっていること"do
      expect(crop).to eq Crop.first
    end
  end
end
