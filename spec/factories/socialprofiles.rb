FactoryBot.define do
  factory :social_profile do
    provider { 'twitter' }
    uid { '1234' }
    association :user
  end
end