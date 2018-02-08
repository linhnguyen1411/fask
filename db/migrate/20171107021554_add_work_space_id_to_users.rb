class AddWorkSpaceIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :work_space_id, :integer
  end
end
