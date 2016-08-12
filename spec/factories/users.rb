FactoryGirl.define do 	
	sequence :email do |n|
		"test#{n}@abdullah.com"
	end

	factory :user do 
		first_name "jim"
		last_name "hum"
		email { generate :email }
		password "12345678"
		password_confirmation "12345678"
	end

	factory :admin_user, class: "AdminUser" do 
		first_name "steve"
		last_name "hollan"
		email { generate :email }
		password "12345678"
		password_confirmation "12345678"

	end
end