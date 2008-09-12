# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080912054642) do

  create_table "deleted_items", :force => true do |t|
    t.text     "name",       :limit => 16777215
    t.text     "address",    :limit => 16777215
    t.text     "tel",        :limit => 16777215
    t.text     "email",      :limit => 16777215
    t.text     "fax",        :limit => 16777215
    t.text     "desc",       :limit => 16777215
    t.float    "lat"
    t.float    "lng"
    t.integer  "quantity",   :limit => 11
    t.boolean  "processed"
    t.boolean  "is_checked"
    t.datetime "deleted_at"
    t.string   "uuid"
  end

  create_table "friends", :force => true do |t|
    t.text    "name",     :limit => 16777215
    t.text    "twitter",  :limit => 16777215
    t.text    "gtalk",    :limit => 16777215
    t.text    "address",  :limit => 16777215
    t.text    "tel",      :limit => 16777215
    t.text    "email",    :limit => 16777215
    t.text    "fax",      :limit => 16777215
    t.text    "desc",     :limit => 16777215
    t.float   "lat"
    t.float   "lng"
    t.integer "quantity", :limit => 11
    t.string  "uuid"
  end

  create_table "items", :force => true do |t|
    t.text    "name",       :limit => 16777215
    t.text    "address",    :limit => 16777215
    t.text    "tel",        :limit => 16777215
    t.text    "email",      :limit => 16777215
    t.text    "fax",        :limit => 16777215
    t.text    "desc",       :limit => 16777215
    t.float   "lat"
    t.float   "lng"
    t.integer "quantity",   :limit => 11
    t.boolean "processed"
    t.boolean "is_checked",                     :default => false
    t.string  "uuid"
  end

  create_table "regions", :force => true do |t|
    t.string   "name"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id", :limit => 11
    t.integer  "location",    :limit => 11
    t.string   "uuid"
  end

  create_table "sub_regions", :force => true do |t|
    t.string   "name"
    t.float    "lat"
    t.float    "lng"
    t.integer  "region_id",  :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
