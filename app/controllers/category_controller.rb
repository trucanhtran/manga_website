class CategoryController < ApplicationController
  def show
    @categories = Category.all
  end

  def show_category
    @categories = Category.all
    @category = Category.find_by(id: params[:id])
    @products = @category.products.order(current_view_counts: :desc).limit(5)
  end

  def show_hot_products
    @categories = Category.all
    @hot_products = Product.order(current_view_counts: :desc).limit(20)
  end

  def show_new_products
    @categories = Category.all
    @new_products = Product.order(updated_at: :desc).limit(20)
  end
end
