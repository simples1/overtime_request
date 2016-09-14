# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.create(email: "admin@admin.com", 
								 password: "12345678", 
								 password_confirmation: "12345678", 
								 first_name: "admin", 
								 last_name: "boy",
								 phone: "+447453949063")

puts "1 adminuser created"

@user = User.create(email: "aa@aa.com", 
										password: "12345678", 
										password_confirmation: "12345678", 
										first_name: "jim", 
										last_name: "hum",
										phone: "+447453949063")

puts "1 user created"

100.times do |post|
	if post.odd?
		Post.create(date: Date.today, rationale: "#{post} Anything Content", user_id: @user.id, status: 1, overtime_request: 2.5)
	end

	Post.create(date: Date.today, rationale: "#{post} Anything Content", user_id: @user.id, overtime_request: 3.5)

end

puts "100 posts created"
