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
FactoryBot.define do
  factory :reservation do
    association :user, factory: :user, strategy: :create
    association :crop, factory: :crop, strategy: :create
    received_at { Date.tomorrow }
  end
end
