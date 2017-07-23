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

ActiveRecord::Schema.define(version: 20170723005028) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "balance"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

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

  create_table "comments", force: :cascade do |t|
    t.text "message"
    t.integer "rating"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "teacher_id"
    t.integer "score"
  end

  create_table "corrections", force: :cascade do |t|
    t.integer "teacher_id"
    t.bigint "writing_id"
    t.text "body"
    t.string "status", default: "new"
    t.float "task_achievement"
    t.float "coherence_cohesion"
    t.float "lexical_resource"
    t.float "grammar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["teacher_id", "status"], name: "index_corrections_on_teacher_id_and_status"
    t.index ["writing_id"], name: "index_corrections_on_writing_id"
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
    t.string "message_type", default: "msg"
    t.integer "writing_id"
    t.boolean "hide_sender", default: false
    t.boolean "hide_recipient", default: false
    t.string "recipients_emails"
    t.index ["message_type"], name: "index_messages_on_message_type"
    t.index ["writing_id"], name: "index_messages_on_writing_id"
  end

  create_table "promo_codes", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "percent"
    t.integer "limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "comment_id"
    t.bigint "user_id"
    t.float "score", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "teacher_id"
    t.integer "rating"
    t.index ["comment_id"], name: "index_ratings_on_comment_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "recipients", force: :cascade do |t|
    t.bigint "message_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id"], name: "index_recipients_on_message_id"
    t.index ["user_id"], name: "index_recipients_on_user_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "transaction_types", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "from_account"
    t.bigint "to_account"
    t.integer "amount"
    t.string "transaction_description"
    t.bigint "transaction_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "promo_code_id"
    t.string "status"
    t.bigint "writing_id"
    t.index ["promo_code_id"], name: "index_transactions_on_promo_code_id"
    t.index ["transaction_type_id"], name: "index_transactions_on_transaction_type_id"
    t.index ["writing_id"], name: "index_transactions_on_writing_id"
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
    t.string "name"
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

  add_foreign_key "accounts", "users"
  add_foreign_key "corrections", "writings"
  add_foreign_key "follows", "teachers"
  add_foreign_key "follows", "users"
  add_foreign_key "ratings", "comments"
  add_foreign_key "ratings", "users"
  add_foreign_key "recipients", "messages"
  add_foreign_key "recipients", "users"
  add_foreign_key "transactions", "promo_codes"
  add_foreign_key "transactions", "transaction_types"
  add_foreign_key "transactions", "writings"
  add_foreign_key "writings", "tasks"
  add_foreign_key "writings", "users"
end
