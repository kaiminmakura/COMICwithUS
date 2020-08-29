class AdminUsersController < ApplicationController

	def index
		@users = User.all.page(params[:page]).per(10)
	end

	def show
		@user = User.find(params[:id])
  	    @reviews = @user.reviews
	end

  private
  def user_params
  	params.require(:user).permit(:name)
  end

end
