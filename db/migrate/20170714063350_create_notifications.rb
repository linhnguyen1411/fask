class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :user, index: true, foreign_key: true
      t.references :activity, index: true, foreign_key: true
      t.boolean :is_seen, defautl: false

      t.timestamps
    end
  end
end
