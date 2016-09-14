require 'rails_helper'

describe 'navigate' do
  let(:user) { FactoryGirl.create(:user) }
  let(:post) { 
    Post.create(date: Date.today, rationale: "im top of the world", user_id: user.id, overtime_request: 4.5)
  }

  before do
   login_as(user, :scope => :user)
  end
  describe 'index' do
    before do
      visit posts_path
    end

  	it "can be reached" do 
  		expect(page.status_code).to eq(200)
  	end

  	it "has title of Posts" do 
  		expect(page).to have_content(/Posts/)
  	end

    it "has a list of Posts" do 
       @post = FactoryGirl.build_stubbed(:post)
       @post2 = FactoryGirl.build_stubbed(:second_post)

      @post2 = Post.create(date: Date.today, rationale: "post2", user_id: user.id, overtime_request: 2.5)
      visit posts_path
      expect(page).to have_content(/posts1|post2/)
    end

    it "has a scope so that only post creators can see their posts" do 

       other_user = User.create( first_name: "non", last_name: "authorised", email: "pp@pp.com", password: "12345678", password_confirmation: "12345678", phone: "555555555")

       post_from_other_user= Post.create( date: Date.yesterday, rationale: "where you want", user_id: other_user.id, overtime_request: 2.5)

        visit posts_path
       expect(page).to_not have_content("where you want")
    end
  end

  describe do 
    it "has a link from the homepage " do 
      visit posts_path

      click_link("new_post_from_nav")
      expect(page.status_code).to eq(200)
    end  

  end
  describe do 
    it "delete" do 
      logout(:user)
      delete_user = FactoryGirl.create(:user)
      login_as(delete_user, :scope => :user)


      post_to_delete = Post.create(date: Date.today, rationale: "blah blh", user_id: delete_user.id, overtime_request: 2.5)

      visit posts_path

      click_link("delete_post_#{post_to_delete.id}_from_index")
      expect(page.status_code).to eq(200)
    end
  end

   describe 'creation' do
   	before do
  		visit new_post_path
   	end

  	it "has a new form that can be reached" do 
  		expect(page.status_code).to eq(200)
  	end

  	it "can be created from new form page" do 
  		fill_in "post[date]", with: Date.today
      fill_in "post[rationale]", with: "Rationale stuff!"
  		fill_in "post[overtime_request]", with: 4.8

  		expect { click_on "Save" }.to change(Post, :count).by(1)
  	end

  	it "will have a use associated with it" do 
  		fill_in "post[date]", with: Date.today
  		fill_in "post[rationale]", with: "Rationale stuff12!"
      fill_in "post[overtime_request]", with: 4.8

  		click_on "Save"

  		expect(User.last.posts.last.rationale).to eq("Rationale stuff12!")
  	end
  end

  describe "edit" do 
    before do
      @post = FactoryGirl.create(:post)
      visit edit_post_path(@post)
    end

    it "can be edited" do
      visit edit_post_path(post)

      fill_in "post[date]", with: Date.today
      fill_in "post[rationale]", with: "Edited stuff"
      click_on "Save"

      expect(page).to have_content("Edited stuff")
    end

    it "cannot be edited by non authorized user" do 
      logout(:user)
      non_authorized_user = FactoryGirl.create(:non_authorized_user)
      login_as(non_authorized_user, scope: :user)

      visit edit_post_path(post)

      expect(current_path).to eq(root_path)
    end


    it "should not be editable by the post creator if the status is approved" do 
      logout(:user)
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)

      @post.update(user_id: user.id, status: "approved")

      visit edit_post_path(@post)

      expect(current_path).to eq(root_path)
    end
  end


end
























