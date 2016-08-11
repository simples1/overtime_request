require 'rails_helper'

describe 'navigate' do
  before do
   user = User.create(email: "aa@aa.com", password: "12345678", password_confirmation: "12345678", first_name: "jim", last_name: "hum")
   login_as(user, :scope => :user)
  end
  describe 'index' do
  	it "can be reached" do 
  		visit posts_path
  		expect(page.status_code).to eq(200)
  	end

  	it "has title of Posts" do 
  		visit posts_path
  		expect(page).to have_content(/Posts/)
  	end
  end


   describe 'creation' do
   	before do
  		visit new_post_path
   	end

  	it "has a new that can be reached" do 
  		expect(page.status_code).to eq(200)
  	end

  	it "can be created from new form page" do 
  		fill_in "post[date]", with: Date.today
  		fill_in "post[rationale]", with: "Rationale stuff!"
  		click_on "Save"

  		expect(page).to have_content("Rationale stuff!")
  	end

  	it "will have a use associated with it" do 
  		fill_in "post[date]", with: Date.today
  		fill_in "post[rationale]", with: "Rationale stuff12!"
  		click_on "Save"

  		expect(User.last.posts.last.rationale).to eq("Rationale stuff12!")
  	end
  end
end