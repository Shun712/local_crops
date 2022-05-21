# == Schema Information
#
# Table name: chatroom_users
#
#  id           :bigint           not null, primary key
#  last_read_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  chatroom_id  :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_chatroom_users_on_chatroom_id              (chatroom_id)
#  index_chatroom_users_on_user_id                  (user_id)
#  index_chatroom_users_on_user_id_and_chatroom_id  (user_id,chatroom_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (chatroom_id => chatrooms.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe ChatroomUser, type: :model do
  let!(:chatroom_user) { create(:chatroom_user) }

  context 'バリデーション' do
    it '有効な状態であること' do
      expect(chatroom_user).to be_valid
    end

    it "user_idがnilの場合、関係性が無効であること" do
      chatroom_user.user_id = nil
      expect(chatroom_user).not_to be_valid
    end

    it "chatroom_idがnilの場合、関係性が無効であること" do
      chatroom_user.chatroom_id = nil
      expect(chatroom_user).not_to be_valid
    end
  end
end
