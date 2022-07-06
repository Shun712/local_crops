puts 'Start inserting seed "users" ...'

places = [[3420050, '埼玉県吉川市栄町'],
          [3420051, '埼玉県吉川市川野'],
          [3420052, '埼玉県吉川市川富'],
          [3420053, '埼玉県吉川市関'],
          [3420054, '埼玉県吉川市吉川団地'],
          [3420055, '埼玉県吉川市吉川'],
          [3420056, '埼玉県吉川市平沼'],
          [3420057, '埼玉県吉川市須賀'],
          [3420058, '埼玉県吉川市きよみ野'],
          [3420059, '埼玉県吉川市新栄'],
          [3420001, '埼玉県吉川市上内川'],
          [3420002, '埼玉県吉川市下内川'],
          [3420003, '埼玉県吉川市八子新田'],
          [3420004, '埼玉県吉川市鍋小路'],
          [3420005, '埼玉県吉川市川藤'],
          [3420006, '埼玉県吉川市南広島']]
guest_user = ['guestuser@example.com', 'ゲストユーザー', 3420007, '埼玉県吉川市拾壱軒']

places.each do |place|
  user = User.create(
    email: Faker::Internet.unique.email,
    username: Gimei.name,
    postcode: place[0],
    address: place[1],
    password: 'password',
    password_confirmation: 'password',
    confirmed_at: Time.zone.now
  )
  puts "\"#{user.username}\" has created!"
end

guest = User.create(
  email: guest_user[0],
  username: guest_user[1],
  postcode: guest_user[2],
  address: guest_user[3],
  password: 'password',
  password_confirmation: 'password',
  confirmed_at: Time.zone.now
)

# ユーザー
user1 = User.first
user2 = User.second

# フォロー
guest.follow(user1)
user2.follow(guest)

puts "ゲストユーザー has created!"