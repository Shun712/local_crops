# == Schema Information
#
# Table name: feedbacks
#
#  id         :bigint           not null, primary key
#  body       :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_feedbacks_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Feedback, type: :model do
  let(:feedback) { create(:feedback) }
  let(:user) { create(:user) }

  context "バリデーション" do
    it "お問い合わせ内容があれば有効な状態であること" do
      expect(feedback).to be_valid
    end

    it "お問い合わせ内容がなければ無効な状態であること" do
      feedback = build(:feedback, body: nil)
      feedback.valid?
      expect(feedback.errors[:body]).to include('を入力してください')
    end

    it "お問い合わせ内容は1000文字以内であること" do
      body = "a" * 1001
      feedback = build(:feedback, body: body)
      feedback.valid?
      expect(feedback.errors[:body]).to include("は1000文字以内で入力してください")
    end
  end
end
