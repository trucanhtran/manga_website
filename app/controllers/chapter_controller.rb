class ChapterController < ApplicationController
  def show
    @chapter = Chapter.find_by(id: params[:id])
    @product = @chapter.product
    @chapters= @product.chapters.all
  end
end
