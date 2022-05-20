class ChatroomsController < ApplicationController
  def index
    @chatrooms = current_user.chatrooms
                             .includes(:user, :chats)
                             .sorted
                             .page(params[:page])
                             .per(12)
  end

  def show
    @chatroom = current_user.chatrooms
                            .includes(:user)
                            .find(params[:id])
  end
end
