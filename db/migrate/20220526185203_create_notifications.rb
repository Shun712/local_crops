class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :subject, null: false, polymorphic: true
      t.integer :notification_type, null: false
      t.boolean :read, null: false, default: false

      t.timestamps
    end
  end
end
