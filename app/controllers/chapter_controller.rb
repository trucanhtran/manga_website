class ChapterController < ApplicationController
  def show
    @categories = Category.all
    @chapter = Chapter.find_by(id: params[:id])
    @product = @chapter.product
    @chapters= @product.chapters.all.order(updated_at: :asc)
  end

  def change_chapter
    @chapter = Chapter.find_by(id: params[:chapter_id])
    render json: @chapter
  end
end
