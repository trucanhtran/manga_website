class MangaController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.all.limit(8)
    @hot_products = Product.order(current_view_counts: :desc).limit(10)
  end

  def show
    @categories = Category.all
    @product = Product.find_by(id: params[:id])
    @chapters = @product.chapters.all.order(updated_at: :asc)
  end

  def search
    @products = Product.where("title LIKE ?", "%#{params[:keyword]}%")
    respond_to do |format|
      format.html {redirect_to :show_result}
    end

    def show_result
      @categories = Category.all
      @products = Product.where("title LIKE ?", "%#{params[:keyword]}%")
    end
  end
end
