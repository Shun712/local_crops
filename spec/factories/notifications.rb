# == Schema Information
#
# Table name: notifications
#
#  id                :bigint           not null, primary key
#  notification_type :integer          not null
#  read              :boolean          default(FALSE), not null
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
FactoryBot.define do
  factory :notification do
    user { nil }
    subject { nil }
    notification_type { 1 }
    read { false }
  end
end
