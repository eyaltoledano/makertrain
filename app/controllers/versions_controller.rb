class VersionsController < ApplicationController
  def show
    if params[:product_id].to_i > 0
      @product = Product.find(params[:product_id])
    else
      @product = Product.find_by_slug(params[:product_id])
    end
    @user = @product.user
    @version = Version.find(params[:id])
  end

  def new
    set_current_user
    redirect_if_not_logged_in
    if params[:product_id].to_i > 0
      @product = Product.find(params[:product_id])
    else
      @product = Product.find_by_slug(params[:product_id])
    end

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
