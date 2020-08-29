class HomesController < ApplicationController
  def top
  	sql = 'select comics.id, comics.title, avg(reviews.rank) as "avg_rank" from comics inner join reviews on comics.id = reviews.comic_id group by reviews.comic_id order by "avg_rank" desc limit 5;'
  	@comics = Comic.find_by_sql(sql)
  	@all_ranks = User.find(Favorite.group(:user_id).order('count(user_id) desc').limit(10).pluck(:user_id))
  end
end
