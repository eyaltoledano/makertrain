class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :logged_in?
  helper_method :set_current_user
  helper_method :redirect_if_not_logged_in

  def current_user
    User.find(session[:user_id])
  end

  def logged_in?
    session[:user_id].present?
  end

  def set_current_user
    if logged_in?
      @user = User.find(session[:user_id])
    end
  end

  def redirect_if_not_logged_in
    if !logged_in?
      flash[:notice] = "You need to be logged in to access this page."
      redirect_to login_path
    end
  end

end
