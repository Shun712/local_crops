puts 'Start inserting seed "crops" ...'
User.limit(3).each do |user|
  crop = user.crops.new(name: Faker::Food.vegetables,
                        description: Faker::Hacker.say_something_smart,
                        harvested_on: Faker::Date.between(from: 3.days.ago, to: Date.today)
  )
  crop.picture.attach(io: File.open(Rails.root.join('app/assets/images/test.png')), filename: 'test.png')
  crop.save!
  puts "crop#{crop.id} has created!"
end