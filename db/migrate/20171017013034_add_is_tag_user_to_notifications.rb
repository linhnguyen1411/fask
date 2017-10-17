class AddIsTagUserToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :is_tag_user, :boolean, default: false
  end
end
