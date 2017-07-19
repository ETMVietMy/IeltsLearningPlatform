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


ActiveRecord::Schema.define(version: 20170718175002) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"


  create_table "comments", force: :cascade do |t|
    t.text "message"
    t.integer "rating"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "teacher_id"

  create_table "attachments", force: :cascade do |t|
    t.string "attachment"
    t.integer "attached_item_id"
    t.string "attached_item_type"
    t.string "original_filename"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attached_item_id", "attached_item_type"], name: "index_attachments_on_attached_item_id_and_attached_item_type"

  end

  create_table "follows", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id"], name: "index_follows_on_teacher_id"
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "sender"
    t.string "subject"
    t.text "content"
    t.boolean "is_read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipients", force: :cascade do |t|
    t.bigint "message_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_recipients_on_message_id"
    t.index ["user_id"], name: "index_recipients_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.integer "task_number"
  end

  create_table "teachers", force: :cascade do |t|
    t.bigint "user_id"
    t.string "nationality"
    t.decimal "price"
    t.text "experience"
    t.string "linkedin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_teachers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "username", default: "", null: false
    t.string "role", default: "STD", null: false
    t.string "status", default: "active", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "writings", force: :cascade do |t|
    t.text "task_description"
    t.string "task_type"
    t.bigint "task_id"
    t.bigint "user_id"
    t.integer "teacher_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "answer"
    t.index ["task_id"], name: "index_writings_on_task_id"
    t.index ["user_id"], name: "index_writings_on_user_id"
  end

  add_foreign_key "follows", "teachers"
  add_foreign_key "follows", "users"
  add_foreign_key "recipients", "messages"
  add_foreign_key "recipients", "users"
  add_foreign_key "writings", "tasks"
  add_foreign_key "writings", "users"
end
