class AddUsedCountToTags < ActiveRecord::Migration[5.0]
  def change
    add_column :tags, :used_count, :integer, default: 1
  end
end
