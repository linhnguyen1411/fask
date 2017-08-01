class CreateWorkSpaces < ActiveRecord::Migration[5.0]
  def change
    create_table :work_spaces do |t|
      t.string :name, null: false
      t.string :area
      t.string :image
      t.text :description

      t.timestamps
    end
  end
end
