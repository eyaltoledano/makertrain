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
          auth[:info][:username] ? u.username = auth[:info][:username] : u.username = auth[:info][:nickname]
          u.email = auth[:info][:email]
          auth[:info][:image] ? u.image = auth[:info][:image] : u.image = auth[:info][:avatar]
          u.uid = auth[:uid]
          # set a password for the user
          u.password = SecureRandom.hex
        end
        session[:user_id] = @user.id
        redirect_to dashboard_path
      end
    else
      # normal login via login form
      user = User.find(email: params[:email])
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
