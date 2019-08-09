class ProductsController < ApplicationController
  def index
    set_current_user
    @products = Product.all
  end

  def new
    set_current_user
    redirect_if_not_logged_in
    @product = @user.products.build
    @version = @product.versions.build(version_number: "v1")
  end

  def create
    set_current_user
    if product_params[:name] == "" || product_params[:description] == "" || product_params[:git_repo] == ""
      flash[:notice] = "You're missing some information. Let's try again."
      render :new
    else
      product_params[:name].chomp
      @product = @user.products.build(product_params)
      @product.status = "New"
      @product.save
      flash[:notice] = "#{@product.name} was successfully created!"
      redirect_to product_path(@product)
    end
  end

  def show
    set_current_user
    @product = Product.find(params[:id])
  end

  def edit
    set_current_user
    redirect_if_not_logged_in
  end

  def update
  end

  def destroy
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :website, :git_repo, :user_id)
  end

end
