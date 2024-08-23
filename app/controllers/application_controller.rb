class ApplicationController < ActionController::Base
  # this method is now available in all the controllers, it's no longer in helper folder, so we have to mention that this is also a helper method
  helper_method :current_user, :logged_in? # this now makes current_user available in views as well

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end
  

  def require_user
    if !logged_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end
end
