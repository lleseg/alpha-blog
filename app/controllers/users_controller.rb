# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :user_by_id, only: %i[show edit update destroy]
  before_action :require_user, only: %i[edit update destroy]
  before_action :require_same_user, only: %i[edit update destroy]

  def new
    @user = User.new
  end

  def show
    @pagy, @articles = pagy(:offset, @user.articles, limit: 10)
  end

  def index
    @users = User.all
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username}!"
      redirect_to articles_path
    else
      render "new", status: 422
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User was updated successfully."
      redirect_to @user
    else
      render "edit", status: 422
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and all related articles was deleted successfully."
    redirect_to users_path
  end

  private

  def user_by_id
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    return if current_user == @user || current_user.admin?

    flash[:alert] = "You can only manage your own user"
    redirect_to @user
  end
end
