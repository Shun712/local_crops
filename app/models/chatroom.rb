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

  def self.find_or_create(users)
    user_ids = users.pluck(:id).sort
    name = user_ids.join(':')
    chatroom = find_or_create_by(name: name)
    chatroom.users = users
    chatroom
  end
end
