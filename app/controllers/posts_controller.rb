#require 'open-uri'
class PostsController < ApplicationController
  before_filter :signed_in_user, only: [:search, :index, :create, :edit, :destroy]
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
      # Save a string to a file.
     # Save a string to a file.
      myStr = params[:post][:content]
      #fileName = ""
      #fileName = params[:user][:name] + "_" + params[:user][:id] 
      fileName = "#{current_user.name}_#{current_user.id}_#{params[:post][:id]}"
      aFile = File.new("C:/Users/adyb/Desktop/OldProj/#{fileName}.txt", "w")
      aFile.write(myStr)
      aFile.close
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  #def  show
   # respond_to do |show|
   #   show.html
   # end

  #end

  def search
    @users = User.all
    @posts = Post.all
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.all
  end

  def index
    @posts = Post.all
  end
  
  def edit
    @post = Post.find(params[:id])  
    #admin_or_owner_required(@post.user.id) 
  end

  def update
    #@user = User.find(params[:id])
    @post = Post.find(params[:id])  
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