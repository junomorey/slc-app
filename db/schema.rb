# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20171130142752) do

  create_table "admins", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true

  create_table "study_sessions", force: :cascade do |t|
    t.integer "tutor_id"
    t.integer "tutee_id"
    t.integer "time_availability_id"
  end

  create_table "study_sessions_time_availabilities", force: :cascade do |t|
    t.integer "time_availability_id"
    t.integer "study_session_id"
  end

  create_table "time_availabilities", force: :cascade do |t|
    t.string   "day"
    t.time     "end_time"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "time_availabilityable_id"
    t.string   "time_availabilityable_type"
    t.integer  "start_time"
    t.integer  "study_session_id"
  end

  create_table "time_availabilities_tutees", id: false, force: :cascade do |t|
    t.integer "time_availability_id"
    t.integer "tutee_id"
  end

  create_table "time_availabilities_tutors", id: false, force: :cascade do |t|
    t.integer "time_availability_id"
    t.integer "tutor_id"
  end

  create_table "tutee_wait_lists", force: :cascade do |t|
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "total_tutees"
    t.integer  "tutee_id"
  end

  create_table "tutees", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "phone_number"
    t.string   "major"
    t.string   "requested_class"
    t.integer  "sid"
    t.boolean  "in_dsp"
    t.integer  "tutor_id"
    t.string   "last_name"
    t.integer  "semesters_at_cal"
    t.string   "first_name"
    t.string   "grade"
    t.boolean  "DSP"
    t.boolean  "EOP"
    t.boolean  "SBC"
    t.boolean  "FPF"
    t.boolean  "TRSP"
    t.boolean  "UCIEP"
    t.boolean  "BISP"
    t.integer  "study_session_id"
    t.integer  "tutee_wait_list_id"
    t.datetime "waitlist_added_time"
  end

  add_index "tutees", ["email"], name: "index_tutees_on_email", unique: true
  add_index "tutees", ["reset_password_token"], name: "index_tutees_on_reset_password_token", unique: true

  create_table "tuteesids", force: :cascade do |t|
    t.string "SID"
  end

  create_table "tutors", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "year"
    t.string   "phone_number"
    t.string   "major"
    t.text     "bio"
    t.integer  "sid"
    t.string   "tutor_cohort"
    t.string   "last_name"
    t.integer  "study_session_id"
  end

  add_index "tutors", ["email"], name: "index_tutors_on_email", unique: true
  add_index "tutors", ["reset_password_token"], name: "index_tutors_on_reset_password_token", unique: true

  create_table "tutorsids", force: :cascade do |t|
    t.string "SID"
  end

end
