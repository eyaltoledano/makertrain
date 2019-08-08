ActiveRecord::Schema.define(version: 20190808174652) do

  enable_extension "plpgsql"

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "status"
    t.string   "git_repo"
    t.string   "website"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "reward"
    t.string   "status"
    t.string   "pr_link"
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "version_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.float    "balance"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "uid"
    t.string   "image"
    t.string   "display_name"
    t.integer  "weekly_goal"
  end

  create_table "version_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "version_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "versions", force: :cascade do |t|
    t.string   "version_number"
    t.string   "description"
    t.string   "progress"
    t.date     "release_date"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "user_id"
    t.integer  "product_id"
    t.integer  "planned_budget"
    t.integer  "available_budget"
  end

end
