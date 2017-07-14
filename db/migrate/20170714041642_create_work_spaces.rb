class CreateWorkSpaces < ActiveRecord::Migration[5.0]
  def change
    create_table :work_spaces do |t|
      t.string :name
      t.references :company, index: true, foreign_key: true

      t.timestamps
    end
  end
end
