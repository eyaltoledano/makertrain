class User < ApplicationRecord
  has_secure_password
  has_many :products
  has_many :version_users
  has_many :versions, through: :version_users

  def name
    self.display_name? ? self.display_name : self.username
  end

  def avatar_url
    self.image? ? self.image : "https://api.adorable.io/avatars/285/#{self.email}.png"
  end

  def slug
  	self.username.gsub(" ", "-").downcase
  end

  def has_no_products?
    true if self.products.empty?
  end

  def self.find_by_slug(slug)
  	self.all.find{ |instance| instance.slug == slug }
  end

  def claimed_tasks # outputs array of tasks
    claimed_tasks = []
    Task.all.each do |task|
      claimed_tasks << task if task.user == self
    end
    claimed_tasks
  end

  def claimed_tasks_count
    claimed_tasks.count
  end

  def claimed_tasks_products # outputs array of products with claimed tasks
    products = []
    claimed_tasks.each do |task|
      products << task.product if task.user == self
    end
  end

  def claim(task)
    task.user = self
    task.status = "Claimed"
    task.save
  end

  def open_claimed_tasks
    open_claimed_tasks = []
    claimed_tasks.each do |task|
      open_claimed_tasks << task if task.status != "Completed"
    end
    open_claimed_tasks
  end

  def open_claimed_tasks_count
    open_claimed_tasks.count
  end

  def has_no_claimed_tasks?
    true if open_claimed_tasks_count == 0
  end

  def update_task_status(task, new_status)
    task.status = new_status
    task.save
  end

  def claimed_task_value
    claimed_task_rewards = []
    open_claimed_tasks.each do |task|
      claimed_task_rewards << task.reward.to_f
    end
    claimed_task_rewards.inject(0, :+)
  end

  def pending_balance
    rewards = []
    self.open_claimed_tasks.each do |task|
      rewards << task.reward.to_f if task.status == "Accepted"
    end
    rewards.inject(0, :+)
  end

  def versions
    versions = []
    self.products.each do |product|
      product.versions.each do |version|
        versions << version
      end
    end
    versions
  end

  def tasks_for_review
    items_to_review = []
    self.versions.each do |version|

      version.tasks.each do |task|
        items_to_review << task if task.status == "Ready for Review" || task.status == "Reviewing" || task.status == "PR Submitted" || task.status == "Accepted"
      end
    end
    items_to_review
  end

  def has_items_for_review?
    tasks_for_review.count > 0 ? true : false
  end

  def items_for_review_count
    tasks_for_review.count
  end

  def number_of_products
    self.products.count
  end

  def is_owner_of?(product)
    true if product.user == self
  end

end
