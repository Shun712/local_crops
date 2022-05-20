class ChatsController < ApplicationController
  def create
    @chat = current_user.chats.create(chat_params)
  end

  def edit
    @chat = current_user.chats.find(params[:id])
  end

  def update
    @chat = current_user.chats.find(params[:id])
    @chat.update(chat_update_params)
  end

  def destroy
    @chat = current_user.chats.find(params[:id])
    @chat.destroy!
  end

  private
  def chat_params
    params.require(:chat).permit(:body).merge(chatroom_id: params[:chatroom_id])
  end

  def chat_update_params
    params.require(:chat).permit(:body)
  end
end