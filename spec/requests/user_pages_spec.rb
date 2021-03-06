require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "index" do

    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_selector('title', text: 'All users') }
    it { should have_selector('h1',    text: 'All users') }

    describe "delete links" do

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link('delete') }.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
    
  end
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    let!(:m1) { FactoryGirl.create(:post, user: user, content: "Foo", title: "Title 1") }
    let!(:m2) { FactoryGirl.create(:post, user: user, content: "Bar", title: "Title 2") }

    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }

    describe "posts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(m1.title) }
      it { should have_content(m2.title) }
      it { should have_content(user.posts.count) }
    end
  end


  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end
end

describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end


    end

    describe "edit" do
    	let(:user) { FactoryGirl.create(:user) }
    	before { visit edit_user_path(user) }

    	describe "page" do
      		it { should have_selector('h1',    text: 		"Update your profile") }
      		it { should have_selector('title', text: 		"Edit 	user") }
      
    	end

    	describe "with invalid information" do
      		before { click_button "Save changes" }

      		it { should have_content('error') }
    	end
  	end

  describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_selector('title', text: 'Sign up') }
        it { should have_content('error') }
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }

        it { should have_link('Sign out') }

      end

      	describe "followed by signout" do
        	before { click_link "Sign out" }
        	it { should have_link('Sign in') }
      	end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
  