class AdminComicsController < ApplicationController

  def index
    @comics = Comic.search(params[:search])
                   .all.page(params[:page]).per(10)
  end

  def show
    @comic = Comic.find(params[:id])
    @user = @comic.user
    @reviews = @comic.reviews
    if @comic.reviews.blank?
      @average_review = 0
    else
      @average_review = @comic.reviews.average(:rank).round(2)
    end
  end

  def edit
    @comic = Comic.find(params[:id])
    unless @comic.user == current_user || admin_signed_in?
       redirect_to admin_comics_path
    end
  end

  def update
    @comic = Comic.find(params[:id])
    if @comic.update(comic_params)
       redirect_to admin_comic_path(@comic.id)
    else
       render :edit
    end
  end

  def destroy
    @comic = Comic.find(params[:id])
    @comic.destroy
    redirect_to admin_comics_path
  end

  private
  def comic_params
    params.require(:comic).permit(:title, :title_kana, :author, :publisher, :story, :back_number, :user_id)
  end

end
