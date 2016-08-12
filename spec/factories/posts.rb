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
end