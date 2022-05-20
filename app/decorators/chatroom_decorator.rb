class ChatroomDecorator < ApplicationDecorator
  delegate_all

  def chat_text
    chats.last&.body&.truncate(30) || 'まだメッセージがありません'
  end
end