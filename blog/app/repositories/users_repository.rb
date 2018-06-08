# frozen_string_literal: true

class UsersRepository
  def all
    users = $redis.get('users')

    if users.nil?
      users = User.all.to_json
      $redis.set('users', users)
      $redis.expire('users', 2.minute.to_i)
    end
    @users = JSON.parse(users, object_class: User)
    @users
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
