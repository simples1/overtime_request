FactoryGirl.define do 	
	factory :post do 
		date Date.today
		rationale "Anythion ratioanl"
		user
	end

	factory :second_post, class: "Post" do 
		date Date.today
		rationale "Anything you want"
		user
	end

	factory :post_from_other_user, class: "Post" do 
		date Date.yesterday
		rationale "where you want"
		non_authorized_user
	end
end