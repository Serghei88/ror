# frozen_string_literal: true

class TasksRepository
  def all
    tasks = $redis.get('tasks')

    if tasks.nil?
      tasks = Task.all.to_json
      $redis.set('tasks', tasks)
      $redis.expire('tasks', 2.minute.to_i)
    end
    @tasks = JSON.parse(tasks, object_class: Task)
    return @tasks
  end

  def find(id)
    Task.find(id)
  end

  def new_entity(attrs = nil)
    Task.new(attrs)
  end

  def update_attributes(task,attrs)
    task.update_attributes(attrs)
  end

  def save(task)
    task.save
  end

  def delete(task)
    task.destroy
  end
end
