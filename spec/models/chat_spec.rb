# == Schema Information
#
# Table name: chats
#
#  id          :bigint           not null, primary key
#  body        :text(65535)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  chatroom_id :bigint
#  user_id     :bigint
#
# Indexes
#
#  index_chats_on_chatroom_id  (chatroom_id)
#  index_chats_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (chatroom_id => chatrooms.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Chat, type: :model do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let(:chatroom) { create(:chatroom, name: ["\"#{user.id}\":\"#{other_user.id}\""]) }
  let(:chat) { create(:chat, user: user, chatroom: chatroom) }

  context 'バリデーション' do
    it '有効な状態であること' do
      expect(chat).to be_valid
    end

    it 'メッセージが1000文字以内であること' do
      chat = build(:chat, body: "a" * 1001)
      chat.valid?
      expect(chat.errors[:body]).to include("は1000文字以内で入力してください")
    end
  end
end
