class ComicsController < ApplicationController

  def new
  	@comic = current_user.comics.new
    @tag_list = Tag.all
  end

  def create
  	@comic = Comic.new(comic_params)
    @comic.user_id = current_user.id
    tag_list = params[:comic][:tag_name].split(nil)
  	if @comic.save
       @comic.save_tag(tag_list)
  	   redirect_to comic_path(@comic.id)
    else
       render :new
    end
  end

  def index
  	@comics = Comic.search(params[:search])
                   .all.page(params[:page]).per(10)
    @tag_list = Tag.all
  end

  def show
  	@comic = Comic.find(params[:id])
    @user = @comic.user
    @review = Review.new
    @reviews = @comic.reviews
    @comic_tags = @comic.tags
    if @comic.reviews.blank?
      @average_review = 0
    else
      @average_review = @comic.reviews.average(:rank).round(2)
    end
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

  def total_ranking
    sql = 'select comics.id, comics.title, avg(reviews.rank) as "avg_rank" from comics inner join reviews on comics.id = reviews.comic_id group by reviews.comic_id order by "avg_rank" desc limit 10;'
    @comics = Comic.find_by_sql(sql)
  end

  private
  def comic_params
  	params.require(:comic).permit(:title, :title_kana, :author, :publisher, :story, :back_number, :user_id)
  end

end
