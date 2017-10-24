class AddUserSetingsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :notification_settings, :string
    add_column :users, :email_settings, :string
    add_column :users, :language, :string
  end
end
