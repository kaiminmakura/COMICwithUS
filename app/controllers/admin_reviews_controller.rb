class AdminReviewsController < ApplicationController
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
