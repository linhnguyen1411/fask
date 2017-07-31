class CreateUsersWorkSpaces < ActiveRecord::Migration[5.0]
  def change
    create_table :users_work_spaces, id: false do |t|
      t.references :post, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
    end
  end
end
