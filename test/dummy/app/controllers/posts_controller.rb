class PostsController < ApplicationController
  before_action :set_post, only: %w(show edit update destroy)

  def index
    @posts = Post.all
    respond_with(@posts)
  end

  def show
    respond_with(@post)
  end

  def edit
    respond_with(@post)
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      respond_with(@post, status: 201)
    else
      respond_with(@post, status: 422)
    end
  end

  def update
    if @post.update(post_params)
      respond_with(@post, status: 200)
    else
      respond_with(@post, status: 422)
    end
  end

  def destroy
    respond_with(@post, status: 204) if @post.destroy
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
