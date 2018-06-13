# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    
    @article = articles_repo.find(params[:article_id])
    @comment = articles_repo.new_comment_entity(comment_params)
    @article.comments << @comment
    articles_repo.save(@article)
    redirect_to article_path(@article)
  end

  def destroy
    authenticate_user!
    @article = articles_repo.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @article.comments.delete @comment
    articles_repo.save(@article)
    redirect_to article_path(@article)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :commenter)
  end

  def articles_repo
    @articles_repo ||= ArticlesRepository.new
  end
end
