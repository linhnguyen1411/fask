class CreateContactPoints < ActiveRecord::Migration[5.0]
  def change
    create_table :contact_points do |t|
      t.text :issue
      t.string :position
      t.string :work_space
      t.text :curators

      t.timestamps
    end
  end
end
