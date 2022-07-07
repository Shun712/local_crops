class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @crops = @user.crops
                  .with_attached_picture
                  .order(harvested_on: :desc)
                  .page(params[:page])
                  .per(8)
  end
end
