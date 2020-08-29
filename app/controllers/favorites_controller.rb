class FavoritesController < ApplicationController

	def create
    	review = Review.find(params[:review_id])
    	favorite = current_user.favorites.new(review_id: review.id)
    	favorite.save
    	redirect_to request.referrer
	end

	def destroy
    	review = Review.find(params[:review_id])
    	favorite = current_user.favorites.find_by(review_id: review.id)
    	favorite.destroy
    	redirect_to request.referrer
	end
end
