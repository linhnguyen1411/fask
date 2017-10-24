class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.datetime :deleted_at, index: true
      t.references :user, index: true, foreign_key: true
      t.references :comments, :commentable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
