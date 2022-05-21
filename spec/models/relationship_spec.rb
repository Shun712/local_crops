# == Schema Information
#
# Table name: relationships
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followed_id :bigint           not null
#  follower_id :bigint           not null
#
# Indexes
#
#  index_relationships_on_followed_id                  (followed_id)
#  index_relationships_on_follower_id                  (follower_id)
#  index_relationships_on_follower_id_and_followed_id  (follower_id,followed_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (followed_id => users.id)
#  fk_rails_...  (follower_id => users.id)
#
require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let!(:relationship) { create(:relationship) }

  it "関係性が有効であること" do
    expect(relationship).to be_valid
  end

  it "follower_idがnilの場合、関係性が無効であること" do
    relationship.follower_id = nil
    expect(relationship).not_to be_valid
  end

  it "followed_idがnilの場合、関係性が無効であること" do
    relationship.followed_id = nil
    expect(relationship).not_to be_valid
  end
end
