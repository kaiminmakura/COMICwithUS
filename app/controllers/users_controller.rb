class UsersController < ApplicationController

  def show
  	@user = User.find(params[:id])
  	@reviews = @user.reviews
  end

  private
  def user_params
  	params.require(:user).permit(:name)
  end
end
