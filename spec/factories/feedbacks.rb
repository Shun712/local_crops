# == Schema Information
#
# Table name: feedbacks
#
#  id         :bigint           not null, primary key
#  body       :text(65535)      not null
#  email      :string(255)      not null
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :feedback do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    body { "作物登録方法を教えてください。" }
  end
end
