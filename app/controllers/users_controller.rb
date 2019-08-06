class UsersController < ApplicationController
  def dashboard
    if !current_user
      flash[:notice] = "You need to be logged in to access your dashboard."
      redirect_to root_path
    else
      @user = current_user
    end
  end

  def index
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
