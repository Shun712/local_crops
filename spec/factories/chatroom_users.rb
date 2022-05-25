# == Schema Information
#
# Table name: chatroom_users
#
#  id           :bigint           not null, primary key
#  last_read_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  chatroom_id  :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_chatroom_users_on_chatroom_id              (chatroom_id)
#  index_chatroom_users_on_user_id                  (user_id)
#  index_chatroom_users_on_user_id_and_chatroom_id  (user_id,chatroom_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (chatroom_id => chatrooms.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :chatroom_user do
    association :user, factory: :user, strategy: :create
    association :chatroom, factory: :chatroom, strategy: :create
    last_read_at { "2022-05-21 11:04:34" }
  end
end
