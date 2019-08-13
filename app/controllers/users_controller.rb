class UsersController < ApplicationController
  def dashboard
    set_current_user
    redirect_if_not_logged_in
    @greeting = greeting_helper
    @owned_products = @user.products.count
    @user_owned_products = @user.products
    @status_list = ["Researching", "Writing specs", "In progress", "Ready for Review"]
    @review_status_list = ["Reviewing", "Accepted", "Rejected", "Completed"]
    support_nil_user_balance
  end

  def review
    redirect_if_not_logged_in
    set_current_user
  end

  def claimed
    redirect_if_not_logged_in
    set_current_user
    support_nil_user_balance
  end

  def owned_products
    redirect_if_not_logged_in
    set_current_user
    @products = @user.products
  end

  def index
  end

  def new
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
