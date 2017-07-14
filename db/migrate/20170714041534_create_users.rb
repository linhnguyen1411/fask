class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :avatar
      t.string :chatwork_id
      t.integer :language
      t.references :role, index: true, foreign_key: true

      t.timestamps
    end
  end
end
