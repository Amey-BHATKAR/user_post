require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do

    

  	describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:post, user: user, content: "Lorem ipsum", title: "E Pluribus")
        FactoryGirl.create(:post, user: user, content: "Dolor sit amet", title: "Enum")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content, string: item.title)
        end
      end
    end
   end



end