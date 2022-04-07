# == Schema Information
#
# Table name: social_profiles
#
#  id         :bigint           not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_social_profiles_on_provider_and_uid  (provider,uid) UNIQUE
#  index_social_profiles_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class SocialProfile < ApplicationRecord
  belongs_to :user
  validates :uid, uniqueness: { scope: :provider }

  def set_values(omniauth)
    # すでに同providerでログイン済みか条件分岐
    return if provider.to_s != omniauth['provider'].to_s || uid != omniauth['uid']

    credentials = omniauth['credentials']
    info = omniauth['info']

    access_token = credentials['refresh_token']
    access_secret = credentials['secret']
    credentials = credentials.to_json
    name = info['name']
  end

  def set_values_by_raw_info(raw_info)
    self.raw_info = raw_info.to_json
    save!
  end
end
