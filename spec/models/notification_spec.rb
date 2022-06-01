# == Schema Information
#
# Table name: notifications
#
#  id                :bigint           not null, primary key
#  notification_type :integer          not null
#  read              :boolean          default("unread"), not null
#  subject_type      :string(255)      not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  subject_id        :bigint           not null
#  user_id           :bigint           not null
#
# Indexes
#
#  index_notifications_on_subject  (subject_type,subject_id)
#  index_notifications_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Notification, type: :model do
  let!(:notification) { create(:notification) }

  it 'notificationインスタンスが有効な状態であること' do
    expect(notification).to be_valid
  end

  it 'user_idがnilの場合、無効な状態であること' do
    notification.user_id = nil
    expect(notification).not_to be_valid
  end

  it 'subject_idがnilの場合、無効な状態であること' do
    notification.subject_id = nil
    expect(notification).not_to be_valid
  end
end
