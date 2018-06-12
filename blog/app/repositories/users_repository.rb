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
  end

  def save(user)
    user.save
  end

  def delete(user)
    user.destroy
  end
end
