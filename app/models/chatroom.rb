# == Schema Information
#
# Table name: chatrooms
#
#  id           :bigint           not null, primary key
#  datetime     :datetime
#  last_read_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  partner_id   :integer          not null
#  user_id      :bigint
#
# Indexes
#
#  index_chatrooms_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Chatroom < ApplicationRecord
  belongs_to :user
  has_many :chats
end
