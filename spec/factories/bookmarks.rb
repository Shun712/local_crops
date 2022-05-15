# == Schema Information
#
# Table name: bookmarks
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  crop_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_bookmarks_on_crop_id              (crop_id)
#  index_bookmarks_on_user_id              (user_id)
#  index_bookmarks_on_user_id_and_crop_id  (user_id,crop_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (crop_id => crops.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :bookmark do
    user { nil }
    crop { nil }
  end
end
