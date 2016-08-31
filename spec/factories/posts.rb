FactoryGirl.define do 	
	factory :post do 
		date Date.today
		rationale "Anythion ratioanl"
		overtime_request 2.5
		user
	end

	factory :second_post, class: "Post" do 
		date Date.today
		rationale "Anything you want"
		overtime_request 0.5
		user
	end

	factory :post_from_other_user, class: "Post" do 
		date Date.yesterday
		rationale "where you want"
		overtime_request 2.5
		non_authorized_user
	end
end