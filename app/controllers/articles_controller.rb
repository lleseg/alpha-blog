# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :article_by_id, only: %i[show edit update destroy]
  before_action :require_user, except: %i[show index]
  before_action :require_same_user, only: %i[edit update destroy]

  def show; end

  def index
    @pagy, @articles = pagy(:offset, Article.all, limit: 10)
  end

  def new
    @article = Article.new
  end

  def edit; end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      flash[:notice] = "Article was saved successfully."
      redirect_to @article
    else
      render "new", status: 422
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully."
      redirect_to @article
    else
      render "edit", status: 422
    end
  end

  def destroy
    return unless @article.destroy

    flash[:notice] = "Article was deleted successfully."
    redirect_to articles_path
  end

  private

  def article_by_id
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def require_same_user
    return if current_user == @article.user || current_user.admin?

    flash[:alert] = "You can only manage your own articles"
    redirect_to @article
  end
end
