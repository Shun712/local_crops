FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { 'testpassword' }
    password_confirmation { 'testpassword' }
    # createのときは自動でconfirm
    after(:create) { |user| user.confirm }
  end
end