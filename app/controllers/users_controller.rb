class UsersController < ApplicationController

  def show
  	@user = User.find(params[:id])
  	@reviews = @user.reviews
  					.all.page(params[:page]).per(10)
  end

  def reviewer_ranking
    @all_ranks = User.find(Favorite.group(:user_id).order('count(user_id) desc').limit(10).pluck(:user_id))
  end

  private
  def user_params
  	params.require(:user).permit(:name)
  end
end
