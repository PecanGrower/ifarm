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

ActiveRecord::Schema.define(:version => 20130323165047) do

  create_table "blocks", :force => true do |t|
    t.string   "name"
    t.integer  "farm_id"
    t.integer  "company_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "blocks", ["company_id"], :name => "index_blocks_on_company_id"
  add_index "blocks", ["farm_id"], :name => "index_blocks_on_farm_id"

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ets", :force => true do |t|
    t.integer  "doy"
    t.decimal  "fabian_garcia"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "ets", ["doy"], :name => "index_ets_on_doy"

  create_table "farms", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "company_id"
  end

  add_index "farms", ["company_id"], :name => "index_farms_on_company_id"

  create_table "fields", :force => true do |t|
    t.string   "name"
    t.decimal  "acreage"
    t.integer  "block_id"
    t.integer  "company_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "farm_id"
  end

  add_index "fields", ["block_id"], :name => "index_fields_on_block_id"
  add_index "fields", ["company_id"], :name => "index_fields_on_company_id"
  add_index "fields", ["farm_id"], :name => "index_fields_on_farm_id"

  create_table "irrigations", :force => true do |t|
    t.datetime "time"
    t.integer  "field_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "company_id"
    t.integer  "farm_id"
  end

  add_index "irrigations", ["company_id"], :name => "index_irrigations_on_company_id"
  add_index "irrigations", ["farm_id"], :name => "index_irrigations_on_farm_id"
  add_index "irrigations", ["field_id"], :name => "index_irrigations_on_field_id"

  create_table "kcs", :force => true do |t|
    t.integer  "doy"
    t.decimal  "pecan"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "kcs", ["doy"], :name => "index_kcs_on_doy"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.integer  "company_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
