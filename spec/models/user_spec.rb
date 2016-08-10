require 'rails_helper'

RSpec.describe User, type: :model do
	describe "creation" do
		before do
			@user = User.create(email: "aa@aa.com", password: "12345678", password_confirmation: "12345678", first_name: "jim", last_name: "hum")
		end

		it "can be created" do 
			expect(@user).to be_valid
		end

		it "cannot be created without first_name or last_name" do
			@user.first_name = nil
			@user.last_name = nil
			expect(@user).to_not be_valid
		end
	end
end
