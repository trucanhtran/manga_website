class CommentController < ApplicationController
  def create
    product = Product.find_by(id: params[:id])
    comment = product.comments.create(content: params[:content], user_id: params[:user_id])
    render json: comment
  end
end
