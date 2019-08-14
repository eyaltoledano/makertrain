class Version < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many :version_users
  has_many :users, through: :version_users
  has_many :tasks

  def slug
  	self.name.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
  	self.all.find{ |instance| instance.slug == slug }
  end

  def open_tasks
    self.tasks.where(status: "Open")
  end

  def available_rewards
    rewards = []
    open_tasks.each do |task|
      rewards << task.reward.to_i
    end
    rewards.inject(0){|sum,x| sum + x }
  end

  def tasks_with_contributors
    contributed = []
    self.tasks.each do |task|
      # binding.pry
      if task.user_id != nil
        contributed << task
      end
    end
    contributed
  end

  def unique_contributors
    contributors = []
    self.tasks_with_contributors.each do |task|
      contributors << task.user_id
    end
    contributors = contributors.collect do |c|
      c = User.find(c)
    end
    contributors.uniq
  end

  def progress
    completed = []
    self.tasks.each {|task| completed << task if task.status == "Completed" }
    if completed.empty?
      result = "0"
    else
      result = completed.count.percent_of(self.tasks.count)
    end
    sprintf "%.0f", result
  end

  def total_awarded
    rewarded = []
    @version.tasks.where(status: "Complete").each do |task|
      rewarded << task.reward.to_f
    end
    total_awarded = rewarded.inject(0){|sum,x| sum + x }
  end

  def has_at_least_one_persisted_task?
    # returns true if version has any valid tasks
    valid_tasks = []
    self.tasks.each { |t| valid_tasks << t.id if t.persisted? }
    !valid_tasks.empty?
  end


end
