class CommentsController < ApplicationController
  
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render partial: 'comment', locals: { comment: @comment }
    else
      render status: 500, nothing: true
    end
  end
  
  private 
  def comment_params
    params.require(:comment).permit(:content, :user_id, :parent_id).merge( {article_id: params[:article_id]})
  end
  
end