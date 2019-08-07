class SessionsController < ApplicationController
  def new
  end

  def create
    if auth
      if user = User.where(email: auth[:info][:email]).present?
        # existing user via oauth
        @user = User.where(email: auth[:info][:email]).first
        session[:user_id] = @user.id
        redirect_to dashboard_path
      else
        # new user via oauth
        @user = User.create do |u|
          u.username = auth[:info][:username]
          u.email = auth[:info][:email]
          u.image = auth[:info][:image]
          u.uid = auth[:uid]
          # set a random password for new oauth users
          u.password = SecureRandom.hex
        end
        session[:user_id] = @user.id
        redirect_to dashboard_path
      end
    else
      # normal login via login form (login with email or username)
      params[:email].include?("@") ? user = User.find_by(email: params[:email]) : user = User.find_by(username: params[:email])

      if user && user.authenticate(params[:password])
        # if submission passes
        session[:user_id] = user.id
        redirect_to dashboard_path
      else
        render :new
      end
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
