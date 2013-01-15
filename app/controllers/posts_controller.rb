#require 'open-uri'
class PostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :edit, :destroy]
  before_filter :correct_user,   only: [:edit, :destroy]


  def create
    @post = current_user.posts.build(params[:post])
    if @post.save
      flash[:success] = "Post created!"

      # Create new file called 'filename.txt' at a specified path.
      
     # my_file = File.new("C:/RailsInstaller/rails_projects/user_post/app/Txts/filename.txt","w")
      # Write text to the file.
      #my_file.write "text to be written to file"
      # Close the file.
      #my_file.close

      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def index
    @posts = Post.search(params[:search])
  end
  #def edit
  #end

  def edit
    #@user = User.find(params[:id])
    if @post.update_attributes(params[:post])
      flash[:success] = "Post updated"
      sign_in @user
      redirect_to @user
    else
      render 'posts/edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_url 
  end

  private

    def correct_user
      @post = current_user.posts.find_by_id(params[:id])
      redirect_to root_url if @post.nil?
    end
  
end