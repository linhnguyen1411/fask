class CreateReactions < ActiveRecord::Migration[5.0]
  def change
    create_table :reactions do |t|
      t.integer :target_type
      t.references :user, index: true, foreign_key: true
      t.references :reactiontable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
