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
#  index_chatrooms_on_user_id                 (user_id)
#  index_chatrooms_on_user_id_and_partner_id  (user_id,partner_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :chatroom do
    association :user, factory: :user, strategy: :create
    partner_id  { 2 }
    last_read_at { Time.now }
  end
end
