require "rails_helper"


describe "navigate" do 
	before do
		@adminuser = FactoryGirl.create("admin_user")
		login_as(@adminuser, scope: :user)
	end

	describe "edit" do 
		before do
			@post = FactoryGirl.create(:post)
			visit edit_post_path(@post)
		end

		it "has a status that can be edited onthe form by an admin" do 

			choose 'post_status_approved'
			click_on("Save")
			
			expect(@post.reload.status).to eq("approved")
		end


		it "can not be edit by a non-Admin" do
			logout(:user)
			user = FactoryGirl.create(:user)
			login_as(user, scope: :user)

			visit edit_post_path(@post)

			expect(page).to_not have_content("Approved")

		end
	end
end