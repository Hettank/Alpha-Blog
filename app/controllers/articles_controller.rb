class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit 
  end

  def home
  end

  def create
    @article = Article.new(article_params())
    puts "Error: #{@article}"

    if @article.save
      flash[:notice] = "Article Was Added Successfully"
      redirect_to articles_path
    else
      render 'new', status: 422
    end
  end

  def update
    if @article.update(article_params())
      flash[:notice] = "Article Was Updated Successfully"
      redirect_to articles_path
    else
      render 'edit', status: 22
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end