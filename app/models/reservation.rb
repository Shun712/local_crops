# == Schema Information
#
# Table name: reservations
#
#  id          :bigint           not null, primary key
#  received_at :datetime         not null
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
class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :crop
  validates :user_id, uniqueness: { scope: :crop_id }
  validates :received_at, presence: true
  scope :sorted, -> { order(received_at: :desc) }
end
