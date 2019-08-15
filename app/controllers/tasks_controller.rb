class TasksController < ApplicationController
  def index
    set_current_user
  end

  def show
    set_current_user
    @product = Product.find_by_slug(params[:product_slug])
    @user = @product.user
    @version = Version.find_by_version_number(params[:version_version_number])
    if params[:id].to_i == 0 # if it's 0, it's a string of words (a task_slug)
      @task = Task.find_by_slug(params[:id])
      # binding.pry
    else
      @task = Task.find(params[:id])
    end

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

  def claim
    @task = Task.find(claim_params[:task_id])
    @version = @task.version
    @product = @version.product
    if @task.user.nil?
      current_user.claim(@task)
      flash[:success] = "You successfully claimed Task ##{@task.id}. gl hf!"
      redirect_to product_version_path(@product.slug, @version.version_number)
    else
      flash[:notice] = "Something went wrong. Try again...?"
    end
  end

  def give_up
    @task = Task.find(claim_params[:task_id])
    @version = @task.version
    @product = @version.product
    @task.user = nil
    @task.status = "Open"
    @task.save
    flash[:notice] = "You gave up on #{@task.name}. On to the next!"
    redirect_to claimed_tasks_path
  end

  def update_status
    @task = Task.find(claim_params[:task_id])
    if params[:status] == "Select a status"
      flash[:notice] = "You need to select a new status for #{@task.name}. Please try again."
      redirect_to claimed_tasks_path
    elsif params[:status] == "Ready for Review" && !params[:pr_link].include?("github.com")
      flash[:notice] = "Please make sure to submit your task with a valid Pull Request URL from GitHub. Your PR should be submitted to the project's repository."
      redirect_to claimed_tasks_path
    end

    if params[:status] == "Ready for Review"
      @task.status = "PR Submitted"
    else
      @task.status = params[:status]
    end

    @task.pr_link = params[:pr_link]

    if @task.save
      flash[:notice] = "The status for #{@task.name} was updated to '#{@task.status}'."

      @task_user = @task.user

      if @task.status == "Completed"
        @task_user.balance = @task_user.balance + @task.reward
        @task_user.save
      end
      redirect_to claimed_tasks_path
    else
      flash[:notice] = "Something went wrong trying to update the status for #{@task}. Please verify your submission and try again."
      redirect_to claimed_tasks_path
    end
  end

  def review_task
    @task = Task.find(task_review_params[:task_id])

    if task_review_params[:status] == "Select a new status"
      flash[:notice] = "You need to select a new status for #{@task.name}. Please try again."
      redirect_to review_tasks_path
    end

    @task.status = task_review_params[:status]

    if @task.status == "Completed"
      rewardee = @task.user
      rewardee.balance = 0 if rewardee.balance.nil?
      rewardee.balance += @task.reward.to_f
      rewardee.save
    end

    if @task.save
      flash[:notice] = "The status for #{@task.name} was updated to '#{@task.status}'."
      redirect_to review_tasks_path
    else
      flash[:notice] = "Something went wrong trying to update the status for #{@task}."
      redirect_to review_tasks_path
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

  def claim_params
    params.permit(:task_id)
  end

  def task_review_params
    params.permit(:task_id, :status)
  end
end
