class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post].permit(:title, :description, :picture, :tag_names))
    @post.user = current_user
    @post.save!

    redirect_to posts_path
  end

  def index
    @posts = Post.all
  end

  def destroy
    raise 'hi'
    @post = current_user.posts.find params[:id]
    @post.destroy

    flash[:notice] = 'Successfully deleted'
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'This is not your post!'
  ensure
    redirect_to '/posts'
  end
end
