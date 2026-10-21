# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :category_by_id, only: %i[show edit update]
  before_action :require_admin, except: %i[index show]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:category] = "Category was saved successfully"
      redirect_to @category
    else
      render "new", status: 422
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category updated successfully"
      redirect_to @category
    else
      render "edit", status: 422
    end
  end

  def index
    @pagy, @categories = pagy(:offset, Category.all, limit: 10)
  end

  def show
    @pagy, @articles = pagy(:offset, @category.articles, limit: 10)
  end

  private

  def category_by_id
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    return if logged_in? && current_user.admin?

    flash[:alert] = "Only admins can perform that action"
    redirect_to categories_path
  end
end
