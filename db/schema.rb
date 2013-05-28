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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130528222120) do

  create_table "employments", :force => true do |t|
    t.integer  "partner_id"
    t.integer  "professional_id"
    t.string   "role"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "employments", ["partner_id"], :name => "index_employments_on_partner_id"
  add_index "employments", ["professional_id"], :name => "index_employments_on_professional_id"

  create_table "mentorships", :force => true do |t|
    t.integer  "professional_id"
    t.integer  "student_id"
    t.boolean  "current"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "mentorships", ["professional_id"], :name => "index_mentorships_on_professional_id"
  add_index "mentorships", ["student_id"], :name => "index_mentorships_on_student_id"

  create_table "partners", :force => true do |t|
    t.string   "name"
    t.string   "kind"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "professionals", :force => true do |t|
    t.string   "name"
    t.integer  "phone_number"
    t.string   "email"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "relationships", :force => true do |t|
    t.integer  "partner_id"
    t.integer  "student_id"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "relationships", ["partner_id"], :name => "index_relationships_on_partner_id"
  add_index "relationships", ["student_id"], :name => "index_relationships_on_student_id"

  create_table "students", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "skills"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "phone_number"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "partner_id"
    t.boolean  "admin"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
