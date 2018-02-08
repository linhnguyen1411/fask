class CreateAVersions < ActiveRecord::Migration[5.0]
  def change
    create_table :a_versions do |t|
      t.integer :user_id
      t.text :content
      t.integer :status, default: 0
      t.integer :a_versionable_id
      t.string :a_versionable_type

      t.timestamps
    end
  end
end
