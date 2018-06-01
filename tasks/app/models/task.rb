class Task < ActiveRecord::Base
  attr_accessible :description, :name

  after_save :clear_cache
  after_update :clear_cache
  after_destroy :clear_cache


  def clear_cache
    $redis.del "tasks"
  end
end
