# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170816044502) do

  create_table "activities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "trackable_type"
    t.integer  "trackable_id"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.string   "key"
    t.text     "parameters",     limit: 65535
    t.string   "recipient_type"
    t.integer  "recipient_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["deleted_at"], name: "index_activities_on_deleted_at", using: :btree
    t.index ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
    t.index ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
    t.index ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree
  end

  create_table "admins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",     limit: 65535,                 null: false
    t.integer  "parent_id"
    t.boolean  "best_answer",               default: false
    t.datetime "deleted_at"
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.index ["deleted_at"], name: "index_answers_on_deleted_at", using: :btree
    t.index ["post_id"], name: "index_answers_on_post_id", using: :btree
    t.index ["user_id"], name: "index_answers_on_user_id", using: :btree
  end

  create_table "clips", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "post_id"
    t.integer "user_id"
    t.index ["post_id"], name: "index_clips_on_post_id", using: :btree
    t.index ["user_id"], name: "index_clips_on_user_id", using: :btree
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",    limit: 65535, null: false
    t.datetime "deleted_at"
    t.integer  "user_id"
    t.integer  "post_id"
    t.integer  "answer_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["answer_id"], name: "index_comments_on_answer_id", using: :btree
    t.index ["deleted_at"], name: "index_comments_on_deleted_at", using: :btree
    t.index ["post_id"], name: "index_comments_on_post_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "content",       limit: 65535,             null: false
    t.datetime "deleted_at"
    t.integer  "user_id"
    t.integer  "topic_id"
    t.integer  "work_space_id"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "count_view",                  default: 0
    t.index ["deleted_at"], name: "index_posts_on_deleted_at", using: :btree
    t.index ["topic_id"], name: "index_posts_on_topic_id", using: :btree
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
    t.index ["work_space_id"], name: "index_posts_on_work_space_id", using: :btree
  end

  create_table "posts_tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "post_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_posts_tags_on_post_id", using: :btree
    t.index ["tag_id"], name: "index_posts_tags_on_tag_id", using: :btree
  end

  create_table "reactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "target_type"
    t.datetime "deleted_at"
    t.integer  "user_id"
    t.string   "reactiontable_type"
    t.integer  "reactiontable_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["deleted_at"], name: "index_reactions_on_deleted_at", using: :btree
    t.index ["reactiontable_type", "reactiontable_id"], name: "index_reactions_on_reactiontable_type_and_reactiontable_id", using: :btree
    t.index ["user_id"], name: "index_reactions_on_user_id", using: :btree
  end

  create_table "relationships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "follower_id"
    t.integer  "following_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_relationships_on_deleted_at", using: :btree
  end

  create_table "tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                   null: false
    t.string   "image"
    t.datetime "deleted_at"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "used_count", default: 1
    t.index ["deleted_at"], name: "index_tags_on_deleted_at", using: :btree
  end

  create_table "topices_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "topic_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_topices_users_on_topic_id", using: :btree
    t.index ["user_id"], name: "index_topices_users_on_user_id", using: :btree
  end

  create_table "topics", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_topics_on_deleted_at", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                               null: false
    t.string   "name"
    t.string   "position"
    t.string   "code"
    t.datetime "deleted_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "avatar"
    t.index ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users_work_spaces", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "work_space_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["user_id"], name: "index_users_work_spaces_on_user_id", using: :btree
    t.index ["work_space_id"], name: "index_users_work_spaces_on_work_space_id", using: :btree
  end

  create_table "work_spaces", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                      null: false
    t.string   "area"
    t.string   "image"
    t.text     "description", limit: 65535
    t.datetime "deleted_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["deleted_at"], name: "index_work_spaces_on_deleted_at", using: :btree
  end

  add_foreign_key "answers", "posts"
  add_foreign_key "answers", "users"
  add_foreign_key "clips", "posts"
  add_foreign_key "clips", "users"
  add_foreign_key "comments", "answers"
  add_foreign_key "comments", "posts"
  add_foreign_key "comments", "users"
  add_foreign_key "posts", "topics"
  add_foreign_key "posts", "users"
  add_foreign_key "posts", "work_spaces"
  add_foreign_key "posts_tags", "posts"
  add_foreign_key "posts_tags", "tags"
  add_foreign_key "reactions", "users"
  add_foreign_key "topices_users", "topics"
  add_foreign_key "topices_users", "users"
  add_foreign_key "users_work_spaces", "users"
  add_foreign_key "users_work_spaces", "work_spaces"
end
