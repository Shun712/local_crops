# == Schema Information
#
# Table name: chatrooms
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Chatroom < ApplicationRecord
  has_many :chatroom_users, dependent: :destroy
  has_many :users, through: :chatroom_users
  has_many :chats, dependent: :destroy
  scope :recent, ->(count) { order(created_at: :desc).limit(count) }

  def self.chatroom_for_user(users)
    user_ids = users.map(&:id).sort
    name = user_ids.join(':').to_s
    unless (chatroom = find_by(name: name))
      chatroom = new(name: name)
      chatroom.users = users
      chatroom.save
    end
    chatroom
  end
end
