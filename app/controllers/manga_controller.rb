class MangaController < ApplicationController
  def index
    @categories = Category.all
    @products = Product.all.limit(4)
  end

  def show

  end
end
