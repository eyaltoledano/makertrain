class UsersController < ApplicationController
  def dashboard
    if !current_user
      flash[:notice] = "You need to be logged in to access your dashboard."
      redirect_to login_path
    else
      @user = current_user
    end
  end

  def index
  end

  def new
    @user = User.new
  end

  def create
  end

  def show
  end

  def edit
    if logged_in?
      @user = current_user
    else
      flash[:notice] = "You need to be logged in to change your settings."
      redirect_to login_path
    end
  end


  def update
    if logged_in?
      @user = current_user
      if @user.update(user_params)
        flash[:notice] = "Profile info was updated."
        redirect_to edit_user_path(@user)
      else
        flash[:notice] = "Something wrong happened."
        render :edit
      end
    else
      flash[:notice] = "You need to be logged in to change your profile settings."
      redirect_to login_path
    end
  end

  def destroy
  end

  private
  
  def user_params
    params.require(:user).permit(:display_name, :password, :password_confirmation)
  end
end
