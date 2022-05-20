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
FactoryBot.define do
  factory :chat do
    association :user, factory: :user, strategy: :create
    association :chatroom, factory: :chatroom, strategy: :create
    body { "MyText" }
  end
end
