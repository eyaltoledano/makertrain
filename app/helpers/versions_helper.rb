module VersionsHelper

  def progress_hash(version)
    status_hash = {available: [], in_progress: [], in_review: [], complete: []}
    # First, populate the status_hash with tasks fitting into the statuses
    version.tasks.each do |task|
      case task.status
        when "New"
          status_hash[:available] << task
        when "Researching" || "Writing specs" || "In progress" || "Ready for Review"
          status_hash[:in_progress] << task
        when "Reviewing" || "Accepted" || "Rejected"
          status_hash[:in_review] << task
        when "Completed"
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


end
