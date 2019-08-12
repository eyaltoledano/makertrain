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
    # if the param after /products/ is a number, look for ID.
    # if the param after /products/ is a string, look for a product whose slug is the same as params[:slug]
    if params[:slug].to_i > 0
      @product = Product.find(params[:slug])
    else
      returned_product = []
      Product.all.each do |p|
        returned_product << p if p.slug == params[:slug]
      end

      if returned_product.empty?
        flash[:notice] = "This product doesn't exist."
        redirect_to products_path
      else
        @product = returned_product.first
      end
    end
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
