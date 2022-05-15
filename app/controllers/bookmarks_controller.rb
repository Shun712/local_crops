class BookmarksController < ApplicationController
  def index
    @bookmarks = current_user.bookmarks
                             .includes(:user)
                             .page(params[:page])
                             .per(12)
  end

  def create
    @crop = Crop.find(params[:crop_id])
    current_user.bookmark(@crop)
  end

  def destroy
    @crop = Bookmark.find(params[:id]).crop
    current_user.unbookmark(@crop)
  end
end
