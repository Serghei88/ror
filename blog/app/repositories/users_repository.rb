# frozen_string_literal: true

class UsersRepository
  def all
    User.all
  end

  def find(id)
    User.find(id)
  end

  def new_entity(attrs = nil)
    User.new(attrs)
  end

  def update_attributes(user, attrs)
    user.update_attributes(attrs)
    clear_cache
  end

  def save(user)
    user.save
    clear_cache
  end

  def delete(user)
    user.destroy
    clear_cache
  end

  def clear_cache
    $redis.del 'users'
  end
end
