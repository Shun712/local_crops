class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @crops = @user.crops.order(harvested_on: :desc).page(params[:page]).per(8)
  end
end
