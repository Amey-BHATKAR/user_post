require 'spec_helper'

describe "Post pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "post creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a post" do
        expect { click_button "Post" }.not_to change(Post, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'post_content', with: "Lorem ipsum" && fill_in 'post_title', with: "E Pluribus Enum" }
      it "should create a post" do
        expect { click_button "Post" }.to change(Post, :count).by(1)
      end
    end
  end

    describe "edit" do
      let(:user) { FactoryGirl.create(:post) }
      before { visit edit_post_path(user) }

      describe "page" do
          it { should have_selector('h1',    text:    "Update your post") }
          it { should have_selector('title', text:    "Edit   post") }
      
      end

      describe "with invalid information" do
          before { click_button "Save changes" }

          it { should have_content('error') }
      end

      describe "with valid information" do
        before { fill_in 'post_content', with: "Lorem ipsum" && fill_in 'post_title', with: "E Pluribus Enum"}
        it "should create a post" do
          expect { click_link "Edit" }.not_to change(Post, :count)
        end
      end
    end

  describe "post destruction" do
    before { FactoryGirl.create(:post, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a post" do
        expect { click_link "delete" }.to change(Post, :count).by(-1)
      end
    end
  end
end