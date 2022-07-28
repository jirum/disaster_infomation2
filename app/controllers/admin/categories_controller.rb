class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def check_admin
    if current_user.client?
      redirect_to posts_path
    end
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
