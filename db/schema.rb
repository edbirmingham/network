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

ActiveRecord::Schema.define(version: 20170412164443) do

  create_table "affiliations", force: :cascade do |t|
    t.integer  "member_id"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "cohort_assignments", force: :cascade do |t|
    t.integer  "network_event_id"
    t.integer  "cohort_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "cohortians", force: :cascade do |t|
    t.integer  "member_id"
    t.integer  "cohort_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cohorts", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "common_tasks", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "date_modifier"
    t.integer  "owner_id"
    t.index ["owner_id"], name: "index_common_tasks_on_owner_id"
  end

  create_table "communications", force: :cascade do |t|
    t.string   "kind"
    t.text     "notes"
    t.integer  "member_id"
    t.integer  "user_id"
    t.datetime "contacted_on"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "extracurricular_activities", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "extracurricular_activity_assignments", force: :cascade do |t|
    t.integer  "member_id"
    t.integer  "extracurricular_activity_id"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "graduating_class_assignments", force: :cascade do |t|
    t.integer  "graduating_class_id"
    t.integer  "network_event_id"
    t.integer  "user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "graduating_classes", force: :cascade do |t|
    t.integer  "year"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "identities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "address_one"
    t.string   "address_two"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "network_action_id"
    t.integer  "member_id"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "members", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "email"
    t.string   "identity"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "shirt_size"
    t.boolean  "shirt_received"
    t.string   "place_of_worship"
    t.string   "recruitment"
    t.string   "community_networks"
    t.string   "extra_groups"
    t.string   "other_networks"
    t.integer  "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "graduating_class_id"
    t.integer  "school_id"
    t.string   "mongo_id"
    t.boolean  "children_in_birmingham_school"
    t.integer  "identity_id"
    t.index ["identity_id"], name: "index_members_on_identity_id"
  end

  create_table "neighborhoods", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "network_actions", force: :cascade do |t|
    t.integer  "actor_id"
    t.integer  "network_event_id"
    t.string   "action_type"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "network_event_tasks", force: :cascade do |t|
    t.string   "name"
    t.datetime "completed_at"
    t.integer  "common_task_id"
    t.integer  "network_event_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "due_date"
    t.string   "date_modifier"
    t.integer  "owner_id"
    t.index ["common_task_id"], name: "index_network_event_tasks_on_common_task_id"
    t.index ["network_event_id"], name: "index_network_event_tasks_on_network_event_id"
    t.index ["owner_id"], name: "index_network_event_tasks_on_owner_id"
  end

  create_table "network_events", force: :cascade do |t|
    t.string   "name"
    t.integer  "location_id"
    t.datetime "scheduled_at"
    t.integer  "user_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "program_id"
    t.integer  "duration",             default: 60
    t.boolean  "needs_transport"
    t.datetime "transport_ordered_on"
    t.text     "notes"
    t.string   "status"
    t.string   "mongo_id"
    t.index ["program_id"], name: "index_network_events_on_program_id"
  end

  create_table "organization_assignments", force: :cascade do |t|
    t.integer  "network_event_id"
    t.integer  "organization_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string   "name"
    t.integer  "created_by_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "participations", force: :cascade do |t|
    t.string   "level"
    t.integer  "member_id"
    t.integer  "network_event_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "programs", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "abbreviation"
  end

  create_table "residences", force: :cascade do |t|
    t.integer  "member_id"
    t.integer  "neighborhood_id"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "school_assignments", force: :cascade do |t|
    t.integer  "network_event_id"
    t.integer  "school_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "school_contact_assignments", force: :cascade do |t|
    t.integer  "member_id"
    t.integer  "network_event_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "site_contact_assignments", force: :cascade do |t|
    t.integer  "network_event_id"
    t.integer  "member_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "talent_assignments", force: :cascade do |t|
    t.integer  "talent_id"
    t.integer  "member_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "talents", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "volunteer_assignments", force: :cascade do |t|
    t.integer  "member_id"
    t.integer  "network_event_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

end
