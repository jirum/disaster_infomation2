class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def index
    @comments = @post&.comments&.includes(:user)
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
