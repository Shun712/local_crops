# == Schema Information
#
# Table name: chats
#
#  id          :bigint           not null, primary key
#  body        :text(65535)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  chatroom_id :bigint
#  user_id     :bigint
#
# Indexes
#
#  index_chats_on_chatroom_id  (chatroom_id)
#  index_chats_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (chatroom_id => chatrooms.id)
#  fk_rails_...  (user_id => users.id)
#
class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom
  has_one :notification, as: :subject, dependent: :destroy
  validates :body, presence: true, length: { maximum: 1000 }
  scope :recent, ->(count) { order(created_at: :desc).limit(count) }
  after_create_commit :create_notifications

  private

  def create_notifications
    Notification.create(user: user.partner(chatroom), subject: self, notification_type: :chat_to_me)
  end
end
