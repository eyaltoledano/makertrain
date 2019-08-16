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
          if auth[:info][:nickname].present?
            u.username = auth[:info][:nickname]
          else
            u.username = auth[:info][:username]
          end
          u.email = auth[:info][:email]
          if auth[:info][:image].present?
            u.image = auth[:info][:image]
          else
            u.image = auth[:info][:avatar]
          end
          u.uid = auth[:uid]
          # set a random password for new oauth users
          u.password = SecureRandom.hex
        end
        session[:user_id] = @user.id
        flash[:notice] = "Welcome to Makertrain! You should take a second to set a password and a custom display name if you'd like one."
        redirect_to edit_user_path(@user)
      end
    else
      # normal login via login form (login with email or username)
      params[:email].include?("@") ? user = User.find_by(email: params[:email]) : user = User.find_by(username: params[:email])

      if user && user.authenticate(params[:password])
        # if submission passes
        session[:user_id] = user.id
        redirect_to dashboard_path
      else
        flash[:notice] = "Something went wrong trying to log in. Mind trying again?"
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
