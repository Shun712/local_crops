# == Schema Information
#
# Table name: crops
#
#  id           :bigint           not null, primary key
#  description  :text(65535)
#  harvested_on :date
#  name         :string(255)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_crops_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :crop do
    user { nil }
    name { "MyString" }
    description { "MyText" }
    havested_on { "2022-04-25" }
  end
end
