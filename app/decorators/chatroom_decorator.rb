class ChatroomDecorator < ApplicationDecorator
  delegate_all

  def chat_text
    chats.last&.body&.truncate(30) || 'まだメッセージがありません'
  end

  def created_at
    chats.last&.created_at&.strftime('%Y/%m/%d %H:%M')
  end
end