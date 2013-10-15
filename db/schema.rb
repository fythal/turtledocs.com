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

ActiveRecord::Schema.define(:version => 20131012050833) do

  create_table "data_files", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "documents", :force => true do |t|
    t.string   "model_id"
    t.string   "name"
    t.string   "url"
    t.string   "filepath"
    t.text     "notes"
    t.string   "status",       :default => "active"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "content_type"
    t.integer  "file_size"
  end

  create_table "equipment", :force => true do |t|
    t.string   "name"
    t.text     "notes"
    t.string   "status",     :default => "active"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "favorite_docs", :force => true do |t|
    t.integer  "user_id"
    t.integer  "document_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "logs", :force => true do |t|
    t.integer  "user_id"
    t.string   "controller"
    t.string   "action"
    t.string   "params"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "models", :force => true do |t|
    t.integer  "equipment_id"
    t.string   "name"
    t.text     "notes"
    t.string   "status",       :default => "active"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "my_invoice_table", :force => true do |t|
    t.integer  "job_id",                                               :null => false
    t.string   "quickbooks_TxnID",        :limit => 40,                :null => false
    t.string   "quickbooks_EditSequence", :limit => 20,                :null => false
    t.datetime "TimeCreated",                                          :null => false
    t.datetime "TimeModified",                                         :null => false
    t.integer  "RefNumber",                                            :null => false
    t.string   "Customer_ListID",         :limit => 40,                :null => false
    t.string   "Customer_FullName",                                    :null => false
    t.string   "ShipAddress_Addr1",       :limit => 50,                :null => false
    t.string   "ShipAddress_Addr2",       :limit => 50,                :null => false
    t.string   "ShipAddress_City",        :limit => 50,                :null => false
    t.string   "ShipAddress_State",       :limit => 25,                :null => false
    t.string   "ShipAddress_Province",    :limit => 25,                :null => false
    t.string   "ShipAddress_PostalCode",  :limit => 16,                :null => false
    t.float    "BalanceRemaining",                                     :null => false
    t.integer  "IsActive",                              :default => 0
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

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
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
