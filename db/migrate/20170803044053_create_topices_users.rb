class CreateTopicesUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :topices_users do |t|
      t.references :topic, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
