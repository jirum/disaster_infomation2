class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_own_post, only: [:destroy, :edit, :update]

  def index
    @posts = Post.all.includes(:user).page(params[:page]).per(5).order('comments_count DESC')
    @domain = request.base_url
  end

  def redirect
    @short_ext = params[:short_url]
    @post = Post.find_by(short_url: @short_ext)
    redirect_to post_path(@post)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post= Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    if @post.comments.present?
      flash[:notice] = "You cannot delete this"
    else
      @post.destroy
      redirect_to posts_path
    end
  end

  private

  def set_own_post
    @post = current_user.posts.find(params[:id])
    if @post.nil?
      flash[:alert] = 'This post is not belongs to you or not exists'
      redirect_to posts_path
    end
  end

  def post_params
    params.require(:post).permit(:title, :content, :address, :category_id, :image)
  end
end
