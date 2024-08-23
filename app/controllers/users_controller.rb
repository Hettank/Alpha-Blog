class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_user, only: [:edit, :update]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
    @page_title = "Sign Up"
    @btn_name = "Sign Up"
  end

  def create
    @user = User.new(user_params())
    
    if @user.save
      flash[:notice] = "You've successfully signedup"
      session[:user_id] = @user.id # log in user as soon as they signup
      redirect_to articles_path
    else
      render 'new', status: 422
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and All the associated articles are successfully deleted"
    redirect_to articles_path
  end

  def show
    @users = User.all
  end

  def index
    @users = User.all
  end

  def edit 
    @page_title = "Edit Your Profile"
    @btn_name = "Update Account"
  end

  def update
    if @user.update(user_params())
      flash[:notice] = "User Was Updated Successfully"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end
  
  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    if current_user != @user && !current_user.admin?
      flash[:alert] = "you can only edit your own account"
      redirect_to @user
    end
  end
end