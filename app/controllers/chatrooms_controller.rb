class ChatroomsController < ApplicationController
  def index
    @chatrooms = current_user.chatrooms.order(created_at: :desc).page(params[:page]).per(12)
  end

  def create
    user = User.find(params[:id])
    @chatroom = Chatroom.chatroom_for_partner(user)
    @chats = @chatroom.chats.order(created_at: :desc).limit(100).reverse
    redirect_to chatroom_path(@chatroom)
  end

  def show
    @chatroom = current_user.chatrooms.find(params[:id])
  end
end
