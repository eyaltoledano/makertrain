module UsersHelper

  def user_number
    # used in the signup form to show what the id of the new user will be
    new_user_id = User.all.count + 1
    new_user_id.to_s.rjust(7, '0')
  end

  def tasks_to_work_on_text
    if @user.open_claimed_tasks.count > 1
      "There are #{@user.open_claimed_tasks.count} claimed tasks to work on"
    elsif @user.open_claimed_tasks.count == 1
      "There is 1 open claimed task to work on"
    else
      "You haven't claimed any tasks to work on yet"
    end
  end

  def open_tasks_for_review_text
    "You have #{@user.tasks_for_review.count} open task#{"s" if @user.tasks_for_review.count > 1} to review"
  end

  def dashboard_hero_class_name
    if @greeting[:text] == "Happy moonlighting"
      "hero is-dark is-bold"
    else
      "hero is-bold"
    end
  end

  def pending_balance_class_name
    @user.pending_balance > 0 ? "tag is-warning is-large" : "tag is-dark is-large"
  end

  def subnavigation_class_name(word)
    # sets the value of the subnavigation li class so it shows as active if the user is currently on a page with the requested word
    current_uri = request.env["PATH_INFO"]
    if current_uri.include?(word)
      "is-active"
    end
  end
end
