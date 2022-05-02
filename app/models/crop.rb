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
class Crop < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 1000 }
  validates :harvested_on, presence: true
  has_one_attached :picture
  validate :file_type
  validate :file_size

  private

  def file_type
    pictures.each do |picture|
      if !picture.blob.content_type.in?(%('image/jpeg image/png'))
        errors.add(:pictures, 'は JPEG 形式または PNG 形式のみ選択してください')
      end
    end
  end

  def file_size
    pictures.each do |picture|
      if picture.blob.byte_size > 5.megabytes
        errors.add(:pictures, 'は 5MB 以下のファイルを選択してください')
      end
    end
  end
end
