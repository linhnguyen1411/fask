class CreateTopicManagers < ActiveRecord::Migration[5.0]
  def change
    create_table :topic_managers do |t|
      t.references :user, index: true, foreign_key: true
      t.references :topic, index: true, foreign_key: true

      t.timestamps
    end
  end
end
