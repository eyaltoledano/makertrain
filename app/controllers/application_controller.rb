class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :logged_in?
  helper_method :set_current_user
  helper_method :redirect_if_not_logged_in
  helper_method :greeting_helper

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

  def greeting_helper
    time = Time.now.hour
    if time <= 11 || time == 0
      @greeting = {text: "Have a productive day", emoji: "em-city_sunrise"}
    elsif time >= 11 && time < 18
      @greeting = {text: "Good afternoon", emoji: "em-sun_with_face"}
    elsif time >= 18 && time < 24
      @greeting = {text: "Happy moonlighting", emoji: "crescent_moon"}
    end
  end

end
