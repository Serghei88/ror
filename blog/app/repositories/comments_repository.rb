# frozen_string_literal: true

class CommentsRepository
  def all
    comments = $redis.get('comments')

    if comments.nil?
      comments = Comment.all.to_json
      $redis.set('comments', comments)
      $redis.expire('comments', 2.minute.to_i)
    end
    @comments = JSON.parse(comments, object_class: Comment)
    @comments
    end

  def find(id)
    Comment.find(id)
  end

  def new_entity(attrs = nil)
    Comment.new(attrs)
  end

  def update_attributes(comment, attrs)
    comment.update_attributes(attrs)
    clear_cache
  end

  def save(comment)
    comment.save
    clear_cache
  end

  def delete(comment)
    comment.destroy
    clear_cache
  end

  def clear_cache
    $redis.del 'comments'
  end
    end
