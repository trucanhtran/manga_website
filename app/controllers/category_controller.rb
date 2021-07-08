class CategoryController < ApplicationController
  def show
    @categories = Category.all
  end

  def show_category
    @categories = Category.all
    @category = Category.find_by(id: params[:id])
    @products = @category.products.order(current_view_counts: :desc).limit(5)
  end
end
