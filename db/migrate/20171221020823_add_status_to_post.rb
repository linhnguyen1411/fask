class AddStatusToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :status, :integer, default: 1
  end
end
