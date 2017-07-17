class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :parent_id, default: 0
      t.integer :status
      t.references :owner

      t.timestamps
    end
  end
end
