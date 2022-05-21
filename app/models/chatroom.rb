# == Schema Information
#
# Table name: chatrooms
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Chatroom < ApplicationRecord
  belongs_to :user
  belongs_to :partner, class_name: "User"
  has_many :chats, dependent: :destroy
  scope :sorted, -> { order(created_at: :desc) }
end
