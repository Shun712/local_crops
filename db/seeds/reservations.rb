guest_user = User.find_by(username: 'ゲストユーザー')
user1 = User.second
crop1 = Crop.first
crop2 = Crop.where(user_id: guest_user).second
crop3 = Crop.third
reservation1 = guest_user.reservations.build(crop_id: crop1.id,
                                             received_at: Time.zone.now.tomorrow)
reservation1.save!
puts "reservation#{reservation1.id} has created!"
reservation2 = user1.reservations.build(crop_id: crop2.id,
                                        received_at: Time.zone.now + 60 * 60)
reservation2.save!
puts "reservation#{reservation2.id} has created!"
reservation3 = guest_user.reservations.build(crop_id: crop3.id,
                                             received_at: Time.zone.now.next_month)
reservation3.save!
puts "reservation#{reservation3.id} has created!"