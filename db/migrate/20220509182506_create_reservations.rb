class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :crop, null: false, foreign_key: true
      t.datetime :received_at, null: false

      t.timestamps
      t.index [:user_id, :crop_id], unique: true
    end
  end
end
