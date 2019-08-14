class VersionsController < ApplicationController
  def show
    set_current_user
    @product = Product.find_by_slug(params[:product_slug])
    @user = @product.user
    @version = Version.find_by_version_number(params[:version_number])
    @task = @version.tasks.build(reward: 0)
    @task.product = @product
  end

  def new
    set_current_user
    redirect_if_not_logged_in
    @product = Product.find_by_slug(params[:product_slug])
    @user = @product.user

    if current_user == !@product.user
      flash[:notice] = "Only the owner of #{@product.name} can create new versions."
      redirect_to product_path(@product)
    end
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
