# == Schema Information
#
# Table name: reservations
#
#  id          :bigint           not null, primary key
#  received_at :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  crop_id     :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_reservations_on_crop_id              (crop_id)
#  index_reservations_on_user_id              (user_id)
#  index_reservations_on_user_id_and_crop_id  (user_id,crop_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (crop_id => crops.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let!(:reservation){ create(:reservation)}
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:crop) { create(:crop, user: user) }

  context 'バリデーション' do
    it "有効な状態であること" do
      expect(reservation).to be_valid
    end

    it "名前がなければ無効な状態であること" do
      reservation = build(:reservation, user: nil)
      reservation.valid?
      expect(reservation.errors[:user]).to include("を入力してください")
    end

    it "作物がなければ無効な状態であること" do
      reservation = build(:reservation, crop: nil)
      reservation.valid?
      expect(reservation.errors[:crop]).to include("を入力してください")
    end

    it "受け取り日時がなければ無効な状態であること" do
      reservation = build(:reservation, received_at: nil)
      reservation.valid?
      expect(reservation.errors[:received_at]).to include("を入力してください")
    end
  end
end
