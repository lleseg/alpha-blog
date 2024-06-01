class ArticlesController < ApplicationController
  before_action :article_by_id, only: %i[show edit update destroy]

  def show; end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit; end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = 'Article was saved successfully.'
      redirect_to @article
    else
      render 'new', status: 422
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = 'Article was updated successfully.'
      redirect_to @article
    else
      render 'edit', status: 422
    end
  end

  def destroy
    @article = Article.find(params[:id])
    return unless @article.destroy

    flash[:notice] = 'Article was deleted successfully.'
    redirect_to articles_path
  end

  private

  def article_by_id
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
