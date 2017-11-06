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

ActiveRecord::Schema.define(version: 20171106065751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string "dept"
    t.string "course_no"
    t.text "description"
    t.integer "units"
    t.string "grading_opts"
    t.integer "max_class_size"
    t.string "instructor_id"
    t.boolean "is_graduate_course"
    t.string "prerequisites"
    t.string "full_name"
    t.string "currently_enrolled_students"
    t.index ["instructor_id", "dept", "course_no"], name: "index_courses_on_instructor_id_and_dept_and_course_no", unique: true
    t.index ["instructor_id"], name: "index_courses_on_instructor_id"
  end

  create_table "instructors", id: :string, force: :cascade do |t|
    t.string "rmp_url"
  end

  create_table "periods", id: false, force: :cascade do |t|
    t.time "start_time"
    t.time "end_time"
    t.string "days"
    t.string "period_type"
    t.string "location"
    t.bigint "course_id"
    t.string "currently_enrolled_students"
    t.string "max_class_size"
    t.string "instructor_name"
    t.index ["course_id"], name: "index_periods_on_course_id"
  end

  add_foreign_key "courses", "instructors"
end
