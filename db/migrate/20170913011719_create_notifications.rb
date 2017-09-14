class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :user, index: true, foreign_key: true
      t.references :activity, index: true, foreign_key: true
      t.integer :status, index: true, default: 0
      t.timestamps
    end
    add_index :notifications, [:user_id, :activity_id]
  end
end
