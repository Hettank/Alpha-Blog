class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index, :home]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # displaying individual article
  def show
  end

  def index
    # @articles = Article.all
    @articles = Article.paginate(page: params[:page], per_page: 6)
  end

  def new
    @article = Article.new
  end

  def edit 
  end

  def home
    redirect_to articles_path if logged_in?
  end

  def create
    @article = Article.new(article_params())
    @article.user = current_user
    # puts "Error: #{@article}"
    puts "This is user: #{current_user}"

    if @article.save
      flash[:notice] = "Article Was Added Successfully"
      redirect_to articles_path
    else
      render 'new', status: 422
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article Was Updated Successfully"
      redirect_to articles_path
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy
    flash[:alert] = "Article has been deleted successfully"
    redirect_to articles_path
  end

  private
  
  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own article"
      redirect_to @article
    end
  end
end