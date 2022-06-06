# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  address                :string(255)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  latitude               :float(24)
#  longitude              :float(24)
#  postcode               :integer
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  unconfirmed_email      :string(255)
#  username               :string(255)      default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  context "バリデーション" do
    it "名前、メールアドレスがあれば有効な状態であること" do
      expect(user).to be_valid
    end

    it "名前がなければ無効な状態であること" do
      user = build(:user, username: nil)
      user.valid?
      expect(user.errors[:username]).to include("を入力してください")
    end

    it "メールアドレスがなければ無効な状態であること" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it "重複したメールアドレスなら無効な状態であること" do
      other_user = build(:user, email: user.email)
      other_user.valid?
      expect(other_user.errors[:email]).to include("はすでに存在します")
    end

    it "メールアドレスは小文字で保存されること" do
      email = "ExamPle@example.com"
      user = create(:user, email: email)
      expect(user.email).to eq email.downcase
    end

    it "パスワードがなければ無効な状態であること" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "パスワードは6文字以上であること" do
      password = "a" * 5
      user = build(:user, password: password)
      user.valid?
      expect(user.errors[:password]).to include("は6文字以上で入力してください")
    end

    it "郵便番号がなければ無効な状態であること" do
      user = build(:user, postcode: nil)
      user.valid?
      expect(user.errors[:postcode]).to include("を入力してください")
    end

    it "郵便番号は7文字であること" do
      postcode = '10000005'
      user = build(:user, postcode: postcode)
      user.valid?
      expect(user.errors[:postcode]).to include("は7文字で入力してください")
    end

    it "住所がなければ無効な状態であること" do
      user = build(:user, address: nil)
      user.valid?
      expect(user.errors[:address]).to include("を入力してください")
    end
  end
end
