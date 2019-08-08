class PagesController < ApplicationController
  def home
    set_current_user
  end
end
