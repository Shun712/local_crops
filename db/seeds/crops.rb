puts 'Start inserting seed "crops" ...'
User.limit(10).each do |user|
  crop = user.crops.create({ name: Faker::Food.vegetables,
                             description: Faker::Hacker.say_something_smart,
                             harvested_on: Faker::Date.between(from: 2.days.ago, to: Date.today),
                             picture: [open("#{Rails.root}/db/fixtures/dummy.png")] })
  puts "crop#{crop.id} has created!"
end