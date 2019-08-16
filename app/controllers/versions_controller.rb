class VersionsController < ApplicationController
  def show
    set_current_user
    @product = Product.find_by_slug(params[:product_slug])
    @version = @product.versions.find_by_version_number(params[:version_number])
    @task = @version.tasks.build(reward: 0)
    @task.product = @product
    @version_tasks_claimable_first = @version.tasks_claimable_first # Pagy this
  end

  def new
    set_current_user
    redirect_if_not_logged_in
    @product = Product.find_by_slug(params[:product_slug])
    @version = @product.versions.build
    @version.version_number = @product.next_version_number

    if current_user == !@product.user
      flash[:notice] = "Only the owner of #{@product.name} can create new versions."
      redirect_to product_path(@product)
    end
  end

  def create
    set_current_user
    if params[:product_slug].present?
      @product = Product.find_by_slug(params[:product_slug])
    else
      @product = Product.find(version_params[:product_id])
    end
    @version = @product.versions.build(version_params)
    @version.version_number = @product.next_version_number
    @version.user = @product.user
    binding.pry

    if @product.save
      flash[:notice] = "#{@product.name} #{@version.version_number} was successfully created!"
      redirect_to product_version_path(@product.slug, @version.version_number)
    else
      flash[:notice] = "Something went wrong. Mind giving it another go?"
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def version_params
    params.require(:version).permit(:description, :release_date, :planned_budget, :product_id)
  end
end
