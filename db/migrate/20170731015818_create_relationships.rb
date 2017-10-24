class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :following_id
      t.datetime :deleted_at, index: true
    end
  end
end
