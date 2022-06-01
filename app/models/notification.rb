# == Schema Information
#
# Table name: notifications
#
#  id                :bigint           not null, primary key
#  notification_type :integer          not null
#  read              :boolean          default("unread"), not null
#  subject_type      :string(255)      not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  subject_id        :bigint           not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_notifications_on_subject  (subject_type,subject_id)
#  index_notifications_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Notification < ApplicationRecord
  include Rails.application.routes.url_helpers
  belongs_to :user
  belongs_to :subject, polymorphic: true

  enum notification_type: { reserved_to_own_crop: 0, bookmarked_to_own_crop: 1, followed_me: 2, chat_to_me: 3 }
  enum read: { unread: false, read: true }

  def redirect_path
    case notification_type.to_sym
    when :reserved_to_own_crop
      reservations_path
    when :bookmarked_to_own_crop
      crop_path(subject.crop)
    when :followed_me
      user_path(subject.follower)
    when :chat_to_me
      chatroom_path(subject.chatroom)
    end
  end
end
