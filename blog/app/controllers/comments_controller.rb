# frozen_string_literal: true

class CommentsController < ApplicationController
  
  def create
    authenticate_user!
    @article = articles_repo.find(params[:article_id])
    @comment = comments_repo.new_entity(comment_params)
    @comment.article_id = @article.id
    comments_repo.save(@comment)
    redirect_to article_path(@article)
  end

  def destroy
    authenticate_user!
    @article = articles_repo.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    comments_repo.delete(@comment)
    redirect_to article_path(@article)
    end

  private

  def comment_params
    params.require(:comment).permit(:body, :commenter)
  end

  def comments_repo
    @comments_repo ||= CommentsRepository.new
  end

  def articles_repo
    @articles_repo ||= ArticlesRepository.new
  end
end
