class CreateSocialProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :social_profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :provider
      t.string :uid

      t.timestamps
    end
    add_index :social_profiles, [:provider, :uid], unique: true
  end
end
