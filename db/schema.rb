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

ActiveRecord::Schema.define(version: 20171203154431) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conversations", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "recipient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipient_id"], name: "index_conversations_on_recipient_id"
    t.index ["sender_id"], name: "index_conversations_on_sender_id"
  end

  create_table "course_posts", force: :cascade do |t|
    t.string "title"
    t.integer "grade", default: 0, null: false
    t.integer "subject", default: 0, null: false
    t.integer "time", default: 0, null: false
    t.integer "address"
    t.text "real_address"
    t.decimal "salary", precision: 20, scale: 2
    t.integer "sex_require", default: 0, null: false
    t.integer "degree_require", default: 0, null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "note"
    t.boolean "status", default: true
    t.text "phone"
    t.integer "frequency"
    t.index ["degree_require"], name: "index_course_posts_on_degree_require"
    t.index ["sex_require"], name: "index_course_posts_on_sex_require"
    t.index ["user_id"], name: "index_course_posts_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.integer "teacher_id"
    t.integer "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["student_id"], name: "index_courses_on_student_id"
    t.index ["teacher_id"], name: "index_courses_on_teacher_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.bigint "conversation_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.date "dob"
    t.integer "sex", default: 0, null: false
    t.string "school"
    t.integer "degree", default: 0, null: false
    t.integer "graduation_year"
    t.decimal "salary", precision: 8
    t.text "about_me"
    t.string "phone"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "grades", default: [], array: true
    t.text "subjects", default: [], array: true
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["phone"], name: "index_profiles_on_phone"
    t.index ["sex"], name: "index_profiles_on_sex"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "rater_id"
    t.integer "rated_id"
    t.integer "rate", default: 0
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teacher_posts", force: :cascade do |t|
    t.string "title"
    t.string "grade"
    t.string "subject"
    t.text "time", default: [], array: true
    t.text "address", default: [], array: true
    t.decimal "salary", precision: 8
    t.text "note"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status", default: true
    t.index ["address"], name: "index_teacher_posts_on_address"
    t.index ["grade"], name: "index_teacher_posts_on_grade"
    t.index ["subject"], name: "index_teacher_posts_on_subject"
    t.index ["user_id"], name: "index_teacher_posts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
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
    t.boolean "admin", default: false, null: false
    t.boolean "active", default: true, null: false
    t.boolean "teacher", default: false, null: false
    t.decimal "rate", precision: 5, scale: 2, default: "0.0"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
end
