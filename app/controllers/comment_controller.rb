class CommentController < ApplicationController
  def create
    @comment = Comments.new(params[:content])
    @comment.save
  end

end
