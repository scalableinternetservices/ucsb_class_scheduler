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

ActiveRecord::Schema.define(version: 20171116044020) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "content", default: "", null: false
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_comments_on_course_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "dept"
    t.string "course_no"
    t.text "description"
    t.integer "units"
    t.string "grading_opts"
    t.integer "max_class_size"
    t.string "instructor_id"
    t.boolean "is_graduate_course"
    t.string "name"
    t.index ["instructor_id", "dept", "course_no"], name: "index_courses_on_instructor_id_and_dept_and_course_no", unique: true
    t.index ["instructor_id"], name: "index_courses_on_instructor_id"
  end

  create_table "instructors", id: :string, force: :cascade do |t|
    t.string "rmp_url"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "amount", default: 0, null: false
    t.bigint "course_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id", "user_id"], name: "index_likes_on_course_id_and_user_id", unique: true
    t.index ["course_id"], name: "index_likes_on_course_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "periods", id: false, force: :cascade do |t|
    t.time "start_time"
    t.time "end_time"
    t.string "days"
    t.string "location"
    t.bigint "course_id"
    t.boolean "is_lecture"
    t.index ["course_id"], name: "index_periods_on_course_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest", null: false
    t.string "email", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "comments", "courses"
  add_foreign_key "comments", "users"
  add_foreign_key "courses", "instructors"
  add_foreign_key "likes", "courses"
  add_foreign_key "likes", "users"
end
