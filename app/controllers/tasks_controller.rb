class TasksController < ApplicationController
  def index
    set_current_user
  end

  def show
    set_current_user
    @product = Product.find_by_slug(params[:product_slug])
    @user = @product.user
    @version = Version.find_by_version_number(params[:version_version_number])
    @task = Task.find(params[:id])
    binding.pry
  end

  def new
    set_current_user
    redirect_if_not_logged_in
    @product = Product.find_by_slug(params[:product_slug])
    @user = @product.user
    @version = Version.find_by_version_number(params[:version_version_number])

    if @user != @product.user
      flash[:notice] = "Only the owner of #{@product.name} can create new tasks for #{@version.version_number}."
      redirect_to product_version_path(@product.slug, @version.version_number)
    end
  end

  def create
    set_current_user
    @product = Product.find_by_slug(task_params[:product_slug])
    @user = @product.user
    @version = Version.find_by_version_number(task_params[:version_version_number])

    if task_params.any? == ""
      flash[:notice] = "The task you tried to submit is missing some information. Try again."
      redirect_to product_version_path(@product.slug, @version.version_number)
    else
      @task = @version.tasks.build(
        name: task_params[:name],
        description: task_params[:description],
        reward: task_params[:reward],
        product_id: @product.id,
        version_id: @version_id,
      )
      @task.status = "Open"
      @task.save
      @task.version.tasks << @task
      flash[:notice] = "The task was successfully created."

      redirect_to product_version_path(@product.slug, @version.version_number)
    end
  end

  def edit
    set_current_user
    redirect_if_not_logged_in
    @product = Product.find_by_slug(params[:product_slug])
    @user = @product.user
    @version = Version.find_by_version_number(params[:version_version_number])
    @task = Task.find(params[:id])
  end

  def update
    set_current_user
  end

  def destroy
  end

  private

  def task_params
    params.permit(:name, :description, :reward, :product_slug, :version_version_number)
  end
end
