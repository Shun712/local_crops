class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :crop
  validates :user_id, uniqueness: { scope: :crop_id }
end
