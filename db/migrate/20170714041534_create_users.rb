class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email, null: false, unique: true
      t.string :name
      t.string :position
      t.string :code, unique: true
      t.datetime :deleted_at, index: true

      t.timestamps
    end
  end
end
