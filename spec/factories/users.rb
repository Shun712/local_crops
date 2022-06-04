# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  address                :string(255)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  latitude               :float(24)
#  longitude              :float(24)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  unconfirmed_email      :string(255)
#  username               :string(255)      default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { 'testpassword' }
    password_confirmation { 'testpassword' }
    confirmed_at { Time.current }

    after(:build) do |user|
      user.avatar.attach(io: File.open('spec/fixture/files/avatar.png'), filename: 'avatar.png')
    end
  end
end
