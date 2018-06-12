# frozen_string_literal: true

class ArticlesRepository
  def all
    articles = $redis.get('articles')

    if articles.nil?
      articles = Article.all.to_json
      $redis.set('articles', articles)
      $redis.expire('articles', 2.minute.to_i)
    end
    @articles = JSON.parse(articles, object_class: Article)
    @articles
    end

  def find(id)
    Article.find(id)
  end

  def new_entity(attrs = nil)
    Article.new(attrs)
  end

  def new_comment_entity(attrs = nil)
    comment = Comment.new(attrs)
  end

  def update_attributes(article, attrs)
    article.update_attributes(attrs)
    clear_cache
  end

  def save(article)
    article.save
    clear_cache
  end

  def delete(id)
    article = Article.find(id)
    article.destroy
    clear_cache
  end

  def clear_cache
    $redis.del 'articles'
  end
  end
