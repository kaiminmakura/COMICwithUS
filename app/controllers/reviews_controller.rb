class ReviewsController < ApplicationController

	def create
		@review = Review.new(review_params)
		@review.rank = params[:score]
		@review.save
		redirect_to comic_path(@review.comic)
	end

	def destroy
		@review = Review.find(params[:id])
		@review.destroy
		redirect_to request.referrer
	end

	private
	def review_params
		params.require(:review).permit(:comic_id, :user_id, :title, :body)
	end
end
