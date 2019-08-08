class ProductsController < ApplicationController
  def index
    set_current_user
  end

  def new
    set_current_user
    redirect_if_not_logged_in
  end

  def create
    set_current_user
    redirect_if_not_logged_in
  end

  def show
  end

  def edit
    set_current_user
    redirect_if_not_logged_in
  end

  def update
  end

  def destroy
  end
end
