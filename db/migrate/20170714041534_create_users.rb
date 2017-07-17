class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :avatar
      t.string :chatwork_id
      t.integer :company_id
      t.integer :language
      t.integer :role_id

      t.timestamps
    end
  end
end
