class ChatroomsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    chatroom = current_user.start_chat_with!(user)
    redirect_to chatroom_path(chatroom)
  end

  def show
    @chatroom = current_user.chatrooms.find(params[:id])
  end
end
