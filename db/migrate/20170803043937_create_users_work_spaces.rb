class CreateUsersWorkSpaces < ActiveRecord::Migration[5.0]
  def change
    create_table :users_work_spaces do |t|
      t.references :user, foreign_key: true
      t.references :work_space, foreign_key: true

      t.timestamps
    end
  end
end
