# == Schema Information
#
# Table name: chatrooms
#
#  id           :bigint           not null, primary key
#  datetime     :datetime
#  last_read_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  partner_id   :integer          not null
#  user_id      :bigint
#
# Indexes
#
#  index_chatrooms_on_user_id                 (user_id)
#  index_chatrooms_on_user_id_and_partner_id  (user_id,partner_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Chatroom, type: :model do
  let!(:chatroom) { create(:chatroom) }

  context 'バリデーション' do
    it '有効な状態であること' do
      expect(chatroom).to be_valid
    end

  end
end
