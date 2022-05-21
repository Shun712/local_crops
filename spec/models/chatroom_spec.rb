# == Schema Information
#
# Table name: chatrooms
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
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
