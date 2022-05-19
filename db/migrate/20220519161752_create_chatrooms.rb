class CreateChatrooms < ActiveRecord::Migration[6.1]
  def change
    create_table :chatrooms do |t|
      t.references :user, foreign_key: true
      t.integer :partner_id, null: false
      t.datetime :last_read_at, :datetime
      t.timestamps
    end
  end
end
