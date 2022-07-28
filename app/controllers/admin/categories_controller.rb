class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index
    @categories = Category.all
  end

  private

  def check_admin
    if current_user.client?
      redirect_to posts_path
    end
  end
end
