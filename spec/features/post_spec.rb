require 'rails_helper'

describe 'navigate' do
  before do
   @user = FactoryGirl.create(:user)
   login_as(@user, :scope => :user)
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

      @post2 = Post.create(date: Date.today, rationale: "post2", user_id: @user.id)
      visit posts_path
      expect(page).to have_content(/posts1|post2/)
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
      @post = FactoryGirl.create(:post)
      visit posts_path

      click_link("delete_post_#{@post.id}_from_index")
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

  describe "edit" do 
    before do
     @user = User.create( first_name: "jim", last_name: "hum", email: "aa@ss.com", password: "12345678", password_confirmation: "12345678")
     login_as(@user, :scope => :user)
      @post = Post.create(    date: Date.today, rationale: "Anythion ratioanl", user_id: @user.id)
    end



    it "can be edited" do
      visit edit_post_path(@post)

      fill_in "post[date]", with: Date.today
      fill_in "post[rationale]", with: "Edited stuff"
      click_on "Save"

      expect(page).to have_content("Edited stuff")
    end

    it "cannot be edited by non authorized user" do 
      logout(:user)
      non_authorized_user = FactoryGirl.create(:non_authorized_user)
      login_as(non_authorized_user, scope: :user)

      visit edit_post_path(@post)

      expect(current_path).to eq(root_path)
    end
  end


end
























