# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
@user = User.create(email: "aa@aa.com", password: "12345678", password_confirmation: "12345678", first_name: "jim", last_name: "hum")

puts "1 user created"

100.times do |post|
	Post.create(date: Date.today, rationale: "#{post} Anything Content", user_id: @user.id)
end

puts "100 posts created"
