class MangaController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.all.limit(10)
    @hot_products = Product.order(current_view_counts: :desc).limit(10)
    @new_products = Product.order(updated_at: :desc).limit(10)
  end

  def show
    @categories = Category.all
    @product = Product.find_by(id: params[:id])
    @chapters = @product.chapters.all.order(updated_at: :asc)
  end

  def search
    @categories = Category.all
    @products = Product.where("lower(title) LIKE ?", "%#{params[:keyword]}%")
      respond_to do |format|
        format.html{render :show_result}
        format.js
      end
  end

    def show_result
      @categories = Category.all
      @products = Product.where("title LIKE ?", "%#{params[:keyword]}%")
    end
end
