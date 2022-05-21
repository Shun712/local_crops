class CreateChatroomUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :chatroom_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :chatroom, null: false, foreign_key: true
      t.datetime :last_read_at

      t.timestamps
    end
    add_index :chatroom_users, [:user_id, :chatroom_id], unique: true
  end
end
