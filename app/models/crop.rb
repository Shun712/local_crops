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
  has_many :reservations, dependent: :destroy
  validates :name, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 1000 }
  validates :harvested_on, presence: true
  has_one_attached :picture
  validate :picture_presence
  validates :picture,
            content_type: { in: %w(image/jpeg image/gif image/png), message: 'は有効なファイルを選択してください' },
            size: { less_than: 5.megabytes, message: 'は5MB以下を選択してください' }
  # 1週間以内に収穫した作物を抽出
  scope :harvested_within_a_week, -> { where("harvested_on >= ?", 1.week.ago.beginning_of_day) }
  scope :sorted, -> { order(harvested_on: :desc) }
  # 未予約の作物を抽出
  scope :not_reserved, -> { includes(:reservations).where(reservations: { crop_id: nil }) }

  def harvested_after_a_week?
    harvested_on < 1.week.ago
  end

  private

  def picture_presence
    errors.add(:picture, 'ファイルを添付してください') unless picture.attached?
  end
end
