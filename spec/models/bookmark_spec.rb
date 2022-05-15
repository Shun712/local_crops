# == Schema Information
#
# Table name: bookmarks
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  crop_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_bookmarks_on_crop_id              (crop_id)
#  index_bookmarks_on_user_id              (user_id)
#  index_bookmarks_on_user_id_and_crop_id  (user_id,crop_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (crop_id => crops.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  let!(:bookmark) { create(:bookmark) }

  it 'bookmarkインスタンスが有効な状態であること' do
    expect(bookmark).to be_valid
  end

  it 'user_idがnilの場合、無効な状態であること' do
    bookmark.user_id = nil
    expect(bookmark).not_to be_valid
  end

  it 'crop_idがnilの場合、無効な状態であること' do
    bookmark.crop_id = nil
    expect(bookmark).not_to be_valid
  end
end
