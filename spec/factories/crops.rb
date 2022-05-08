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
    name { Faker::Food.vegetables }
    description { Faker::Hacker.say_something_smart }
    harvested_on { Date.today }
    association :user, factory: :user, strategy: :create

    after(:build) do |crop|
      crop.picture.attach(io: File.open('spec/fixture/files/test.png'), filename: 'test.png')
    end
  end

  trait :yesterday do
    harvested_on { 1.day.ago }
  end

  trait :two_days_ago do
    harvested_on { 2.day.ago }
  end

  trait :three_days_ago do
    harvested_on { 3.day.ago }
  end

  trait :two_weeks_ago do
    harvested_on { 2.weeks.ago }
  end
end
