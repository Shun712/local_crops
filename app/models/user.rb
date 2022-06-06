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
class User < ApplicationRecord
  before_save :downcase_email
  validates :username, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: %i[line twitter]
  has_many :social_profiles, dependent: :destroy
  has_many :crops, dependent: :destroy
  has_one_attached :avatar
  validates :avatar,
            content_type: { in: %w[image/jpeg image/gif image/png], message: 'は有効なファイルを選択してください' },
            size: { less_than: 5.megabytes, message: 'は5MB以下を選択してください' }
  before_create :default_avatar
  has_many :reservations, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_crops, through: :bookmarks, source: :crop
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :chatroom_users, dependent: :destroy
  has_many :chatrooms, through: :chatroom_users
  has_many :chats, dependent: :destroy
  has_many :notifications, dependent: :destroy
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  validates :postcode, length: { is: 7 }

  def self.find_for_oauth!(auth)
    User.joins(:social_profiles)
        .find_by(social_profiles: { uid: auth['uid'], provider: auth['provider'] })
  end

  def self.sign_up(auth)
    user = User.new(
      username: auth['info']['name'],
      email: auth['info']['email'] || Faker::Internet.email,
      password: Devise.friendly_token[0, 20]
    )
    user.skip_confirmation!
    user.save!
    user.social_profiles.create!(
      provider: auth['provider'],
      uid: auth['uid']
    )
    user
  end

  def own?(object)
    id == object.user_id
  end

  def default_avatar
    unless avatar.attached?
      avatar.attach(io: File.open(Rails.root.join('app/assets/images/default-avatar.png')), filename: 'default-avatar.png')
    end
  end

  def bookmark(crop)
    bookmark_crops << crop
  end

  def unbookmark(crop)
    bookmark_crops.destroy(crop)
  end

  def bookmark?(crop)
    bookmark_crops.include?(crop)
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.destroy(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def partner(object)
    if id == object.users.first.id
      object.users.last
    else
      object.users.first
    end
  end

  def distance_within_5km?(object)
    distance = Geocoder::Calculations.distance_between([latitude, longitude],
                                                       [object.user.latitude, object.user.longitude])
    distance < 5.0
  end

  def distance(object)
    distance = Geocoder::Calculations.distance_between([latitude, longitude],
                                            [object.user.latitude, object.user.longitude])
    distance.round(1)
  end
end
