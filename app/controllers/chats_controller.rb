class ChatsController < ApplicationController
  def create
    @chat = current_user.chats.build(chat_params)
    if @chat.save
      ActionCable.server.broadcast(
        "chatroom_#{@chat.chatroom_id}",
        { type: :create, html: (render_to_string partial: 'chat', locals: { chat: @chat }, layout: false), chat: @chat.as_json }
      )
      head :ok
    else
      head :bad_request
    end
  end

  def edit
    @chat = current_user.chats.find(params[:id])
  end

  def update
    @chat = current_user.chats.find(params[:id])
    if @chat.update(chat_update_params)
      ActionCable.server.broadcast(
        "chatroom_#{@chat.chatroom_id}",
        { type: :update, html: (render_to_string partial: 'chat', locals: { chat: @chat }, layout: false), chat: @chat.as_json }
      )
      head :ok
    else
      head :bad_request
    end
  end

  def destroy
    @chat = current_user.chats.find(params[:id])
    @chat.destroy!
    ActionCable.server.broadcast(
      "chatroom_#{@chat.chatroom_id}",
      { type: :delete, html: (render_to_string partial: 'chat', locals: { chat: @chat }, layout: false), chat: @chat.as_json }
    )
    head :ok
  end

  private
  def chat_params
    params.require(:chat).permit(:body).merge(chatroom_id: params[:chatroom_id])
  end

  def chat_update_params
    params.require(:chat).permit(:body)
  end
end