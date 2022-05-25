class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.references :user, foreign_key: true
      t.references :chatroom, foreign_key: true
      t.text :body, null: false

      t.timestamps
    end
  end
end
