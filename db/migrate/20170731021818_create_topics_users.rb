class CreateTopicsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :topics_users, id: false do |t|
      t.references :topic, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
    end
  end
end
