class ComicsController < ApplicationController

  def new
  	@comic = Comic.new
  end

  def create
  	@comic = Comic.new(comic_params)
    @comic.user_id = current_user.id
  	if @comic.save
  	   redirect_to comic_path(@comic.id)
    else
       render :new
    end
  end

  def index
  	@comics = Comic.search(params[:search])
  end

  def show
  	@comic = Comic.find(params[:id])
  end

  def edit
  	@comic = Comic.find(params[:id])
    unless @comic.user == current_user || admin_signed_in?
       redirect_to comics_path
    end
  end

  def update
  	@comic = Comic.find(params[:id])
    if @comic.update(comic_params)
       redirect_to comic_path(@comic.id)
    else
       render :edit
    end
  end

  private
  def comic_params
  	params.require(:comic).permit(:title, :title_kana, :author, :publisher, :story, :back_number, :user_id)
  end

end
