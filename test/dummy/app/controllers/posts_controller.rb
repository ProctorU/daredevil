class PostsController < ApplicationController
  before_action :set_post, only: %w(show)

  def index
  end

  def show
    respond_with @post
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      respond_with(@post)
    else
      respond_with(@post, status: 422)
    end
  end

  def update
  end

  def destroy
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
