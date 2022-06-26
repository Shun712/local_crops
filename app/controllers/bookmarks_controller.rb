class BookmarksController < ApplicationController
  def index
    @crops = Crop.joins(:bookmarks)
                 .where(bookmarks: { user_id: current_user.id })
                 .with_attached_picture
                 .includes(user: {avatar_attachment: :blob })
                 .sorted
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
