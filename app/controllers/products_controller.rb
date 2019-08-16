class ProductsController < ApplicationController
  def index
    set_current_user
    @pagy, @products = pagy(Product.all, items: 10)
    @number_of_products = Product.all.count
    if @products.empty?
      @latest_version_number = nil
      @pretty_latest_version_number = nil
    else
      @latest_version_number = @products.last.latest_version_number
      @pretty_latest_version_number = @products.last.pretty_latest_version_number
    end
  end

  def new
    set_current_user
    redirect_if_not_logged_in
    @product = @user.products.build
    @version = @product.versions.build(version_number: "v1")
  end

  def create
    set_current_user
    if product_params.any? == ""
      flash[:notice] = "You're missing some information. Let's try again."
      render :new
    else
      product_params[:name].chomp
      @product = Product.new(product_params)
      @product.status = "New"
      @product.user = current_user
      if @product.save
        @version = @product.versions.build(version_params)
        @version.user = @product.user
        @version.product = @product
        if @version.save
          flash[:notice] = "#{@product.name} #{@version.version_number} was successfully created!"
          redirect_to product_version_path(@product.slug, @version.version_number)
        else
          flash[:notice] = "Something went wrong"
          render :new
        end
      else
        flash[:notice] = "Something went wrong"
        render :new
      end
    end
  end

  def show
    set_current_user

    if params[:version_number].present?
      @product = Product.find_by_slug(params[:slug])
      @product_user = @product.user
      @version = @product.versions.find_by_version_number(params[:version_number])
    else
      @product = Product.find_by_slug(params[:slug])
      @product_user = @product.user
      @version = @product.versions.last
    end

    if !@version
      @open_tasks = "0"
      @available_rewards = "0"
      @num_of_contributors = []
    else
      @open_tasks = @version.open_tasks.count

      if !@version.tasks.empty?
        rewards = []
        @version.tasks.where(status: "Open").each do |task|
          rewards << task.reward.to_f
        end
        @available_rewards = rewards.inject(0){|sum,x| sum + x }
      else
        @available_rewards = "0"
      end

      @num_of_contributors = @version.tasks_with_contributors
      @versions = @product.versions
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

  def version_params
    params.require(:product).permit(versions_attributes: [:version_number, :description, :release_date, :planned_budget]).values.first.values.first
  end

end
