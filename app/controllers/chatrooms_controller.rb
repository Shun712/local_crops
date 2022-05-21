class ChatroomsController < ApplicationController
  def index
    @chatrooms = current_user.chatrooms
                             .includes(:users, chats: :user)
                             .sorted
                             .page(params[:page])
                             .per(12)
  end

  def create
    users = [current_user]
    users << User.find(params[:user_id])
    @chatroom = Chatroom.chatroom_for_user(users)
    @chats = @chatroom.chats.order(created_at: :desc).limit(100).reverse
    @chatroom_user = current_user.chatroom_users.find_by(chatroom_id: @chatroom.id)
    redirect_to chatroom_path(@chatroom)
  end

  def show
    @chatroom = current_user.chatrooms.find(params[:id])
    @user = current_user.partner(@chatroom)
  end
end
