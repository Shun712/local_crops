puts 'Start inserting seed "users" ...'
3.times do
  user = User.create(
    email: Faker::Internet.unique.email,
    username: Gimei.name,
    postcode: '1000004',
    address: '東京都千代田区大手町',
    password: 'password',
    password_confirmation: 'password',
    confirmed_at: Time.now
  )
  puts "\"#{user.username}\" has created!"
end