module VersionsHelper

  def progress_hash_numbers(version)
    status_hash = {available: [], in_progress: [], in_review: [], complete: []}
    # First, populate the status_hash with tasks fitting into the statuses
    version.tasks.each do |task|

      if task.status == "New" || task.status == "Open"
        status_hash[:available] << task
      elsif task.status ==  "Claimed" || task.status == "Researching" || task.status == "Writing specs" || task.status == "In progress" || task.status == "Ready for Review"
        status_hash[:in_progress] << task
      elsif task.status == "Reviewing" || task.status == "Accepted" || task.status == "Rejected"
        status_hash[:in_review] << task
      elsif task.status == "Completed"
        status_hash[:complete] << task
      end
    end

    # Then, replace the value of each status with the count of how many values there are in each status_hash key
    status_hash = status_hash.each do |status, task_list|
      status_hash[status] = task_list.size
    end
    # Count how many tasks there are in total by summing up all the keys' values
    total_tasks = status_hash.values.inject(0) {|a,b|a+b}
    status_hash
  end

  def progress_hash(version)
    status_hash = {available: [], in_progress: [], in_review: [], complete: []}
    # First, populate the status_hash with tasks fitting into the statuses
    version.tasks.each do |task|

      if task.status == "New" || task.status == "Open"
        status_hash[:available] << task
      elsif task.status ==  "Claimed" || task.status == "Researching" || task.status == "Writing specs" || task.status == "In progress" || task.status == "Ready for Review"
        status_hash[:in_progress] << task
      elsif task.status == "Reviewing" || task.status == "Accepted" || task.status == "Rejected"
        status_hash[:in_review] << task
      elsif task.status == "Completed"
        status_hash[:complete] << task
      end
    end

    # Then, replace the value of each status with the count of how many values there are in each status_hash key
    status_hash = status_hash.each do |status, task_list|
      status_hash[status] = task_list.size
    end
    # Count how many tasks there are in total by summing up all the keys' values
    total_tasks = status_hash.values.inject(0) {|a,b|a+b}
    # 1.percent_of(10)
    # Replace each status key value with the percent it represents of all tasks for the version
    # progress_hash should spit out a hash of the 4 main statuses and the percentage of tasks each status represents (to be fed into progress bar)
    progress_hash = status_hash.each do |status, number_of_tasks|
      if status_hash[status] != 0
        status_hash[status] = number_of_tasks.percent_of(total_tasks)
      end
    end
    # progress_hash {:available=>0.8, :in_progress=>0.1, :in_review=>0.05, :complete=>0.05}
  end

  def progress_bar_class(status)
    case status
    when :available
      "progress-bar-info"
    when :in_progress
      "progress-bar-warning"
    when :complete
      "progress-bar-success"
    end
  end

  def progress_bar_popover_content(version, task_status)
    "#{pluralize(progress_hash_numbers(version)[task_status], 'Task')} #{task_status.to_s.capitalize.humanize.titleize}"
  end

end
