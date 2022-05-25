class ChatroomChannel < ApplicationCable::Channel
  # クライアントがサーバーに接続したと同時に実行されるメソッド
  # chatroom_channel間（chatroom_channel.rbとchatroom_channel.js）でデータを送受信する
  def subscribed
    stream_from "chatroom_#{params[:chatroom_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak; end
end
