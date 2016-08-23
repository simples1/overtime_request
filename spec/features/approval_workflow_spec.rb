require "rails_helper"


describe "navigate" do 
	before do
		@adminuser = FactoryGirl.create("admin_user")
		login_as(@adminuser, scope: :user)
	end

	describe "edit" do 
		before do
			@post = FactoryGirl.create(:post)
		end

		it "has a status that can be edited onthe form" do 
			visit edit_post_path(@post)

			choose 'post_status_approved'
			click_on("Save")
			
			expect(@post.reload.status).to eq("approved")
		end
	end
end