class ChatroomsController < ApplicationController
  def index
    @chatrooms = current_user.chatrooms
                             .includes(:user, chats: :user)
                             .sorted
                             .page(params[:page])
                             .per(12)
  end

  def create
    user = User.find(params[:user_id])

  end

  def show
    @chatroom = current_user.chatrooms.find(params[:id])
    @chats = Chat.where(chatroom_id: @chatroom.id)
  end
end
