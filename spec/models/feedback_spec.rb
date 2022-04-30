# == Schema Information
#
# Table name: feedbacks
#
#  id         :bigint           not null, primary key
#  body       :text(65535)      not null
#  email      :string(255)      not null
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Feedback, type: :model do
  let(:feedback) { create(:feedback) }

  context "バリデーション" do
    it "お問い合わせ内容があれば有効な状態であること" do
      expect(feedback).to be_valid
    end

    it "名前がなければ無効な状態であること" do
      feedback = build(:feedback, name: nil)
      feedback.valid?
      expect(feedback.errors[:name]).to include('を入力してください')
    end

    it "メールアドレスがなければ無効な状態であること" do
      feedback = build(:feedback, email: nil)
      feedback.valid?
      expect(feedback.errors[:email]).to include('を入力してください')
    end

    it "メールアドレスは小文字で保存されること" do
      email = "ExamPle@example.com"
      feedback = create(:feedback, email: email)
      expect(feedback.email).to eq email.downcase
    end

    it "重複したメールアドレスでも有効な状態であること" do
      other_feedback = build(:feedback, email: feedback.email)
      expect(other_feedback).to be_valid
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
