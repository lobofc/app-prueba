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

ActiveRecord::Schema.define(version: 20180312060418) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"

  create_table "appearances", force: :cascade do |t|
    t.string   "image_background"
    t.string   "theme_name"
    t.string   "setting_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "banners", force: :cascade do |t|
    t.string   "banner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "charts", force: :cascade do |t|
    t.string   "name"
    t.string   "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "value_one"
    t.string   "value_two"
  end

  create_table "contests", force: :cascade do |t|
    t.string   "titulo"
    t.text     "descripcion"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
  end

  create_table "customizes", force: :cascade do |t|
    t.string   "file"
    t.boolean  "installed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "google_adwords", force: :cascade do |t|
    t.string   "url"
    t.string   "campaign_name"
    t.text     "description"
    t.text     "script"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "google_analytics_settings", force: :cascade do |t|
    t.string   "ga_account_id"
    t.string   "ga_tracking_id"
    t.boolean  "ga_status"
    t.integer  "setting_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "google_analytics_tracks", force: :cascade do |t|
    t.string   "name"
    t.string   "tracking_id"
    t.string   "url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "indicators", force: :cascade do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "keppler_contact_us_message_settings", force: :cascade do |t|
    t.string   "mailer_to"
    t.string   "mailer_from"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "keppler_contact_us_messages", force: :cascade do |t|
    t.string   "name"
    t.string   "subject"
    t.string   "email"
    t.text     "content"
    t.boolean  "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meta_tags", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "meta_tags"
    t.string   "url"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "settings", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "phone"
    t.string   "mobile"
    t.string   "email"
    t.string   "logo"
    t.string   "favicon"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "smtp_settings", force: :cascade do |t|
    t.string   "address"
    t.string   "port"
    t.string   "domain_name"
    t.string   "email"
    t.string   "password"
    t.integer  "setting_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "social_accounts", force: :cascade do |t|
    t.string   "facebook"
    t.string   "twitter"
    t.string   "instagram"
    t.string   "google_plus"
    t.string   "tripadvisor"
    t.string   "pinterest"
    t.string   "flickr"
    t.string   "behance"
    t.string   "dribbble"
    t.string   "tumblr"
    t.string   "github"
    t.string   "linkedin"
    t.string   "soundcloud"
    t.string   "youtube"
    t.string   "skype"
    t.string   "vimeo"
    t.integer  "setting_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "permalink"
    t.string   "username"
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
