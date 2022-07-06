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
            content_type: { in: %w[image/jpeg image/gif image/png], message: 'は有効なファイルを選択してください' },
            size: { less_than: 5.megabytes, message: 'は5MB以下を選択してください' }
  # 1週間以内に収穫した作物を抽出
  scope :harvested_within_a_week, -> { where('harvested_on >= ?', 1.week.ago.beginning_of_day) }
  scope :sorted, -> { order(harvested_on: :desc) }
  scope :reverse_sorted, -> { order(harvested_on: :asc) }
  # 未予約の作物を抽出
  scope :not_reserved, -> { includes(:reservations).where(reservations: { crop_id: nil }) }
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_users, through: :bookmarks, source: :user
  has_one :notification, as: :subject, dependent: :destroy
  after_create_commit :create_notifications
  acts_as_mappable through: :user
  extend OrderAsSpecified

  def harvested_after_a_week?
    harvested_on < 1.week.ago
  end

  def self.within_distance(object)
    within(5, origin: object.position)
      .includes(:user)
      .harvested_within_a_week
      .not_reserved
  end

  private

  def picture_presence
    errors.add(:picture, 'ファイルを添付してください') unless picture.attached?
  end

  def create_notifications
    user.followers.each do |follower|
      Notification.create(user: follower, subject: self, notification_type: :create_crop_by_follow_user)
    end
  end
end
