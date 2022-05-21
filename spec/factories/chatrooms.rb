# == Schema Information
#
# Table name: chatrooms
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :chatroom do
    association :user, factory: :user, strategy: :create
    partner_id  { 2 }
    last_read_at { Time.now }
  end
end
