class UsersController < ApplicationController
  def dashboard
    set_current_user
    redirect_if_not_logged_in
  end

  def index
  end

  def new
    redirect_if_not_logged_in
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to Makertrain, #{@user.username}!"
      redirect_to dashboard_path
    else
      flash[:notice] = "Something went wrong"
      render :new
    end
  end

  def show
    set_current_user
  end

  def edit
    set_current_user
    redirect_if_not_logged_in
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
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :display_name, :password, :password_confirmation)
  end
end
