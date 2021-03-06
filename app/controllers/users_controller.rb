class UsersController < ApplicationController
  def dashboard
    set_current_user
    redirect_if_not_logged_in
    greeting_helper
    @owned_products = @user.products.count
    @user_owned_products = @user.products
    @status_list = ["Researching", "Writing specs", "In progress", "Ready for Review"]
    @review_status_list = ["Reviewing", "Accepted", "Rejected", "Completed"]
    support_nil_user_balance
  end

  def review
    redirect_if_not_logged_in
    set_current_user
    status_lists
    greeting_helper
    @user_owned_products = @user.products
    @owned_products = @user.products.count
  end

  def claimed
    redirect_if_not_logged_in
    set_current_user
    support_nil_user_balance
    status_lists
    greeting_helper
    @pagy, @user_claimed_tasks = pagy(@user.claimed_tasks, items: 10)
  end

  def owned_products
    redirect_if_not_logged_in
    set_current_user
    @products = @user.products
    @owned_products = @user.products.count
    @user_owned_products = @user.products
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
      flash[:notice] = "Welcome to Indie Makers, #{@user.username}!"
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def show
    set_current_user
    @profile_user = User.find(params[:id])
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
