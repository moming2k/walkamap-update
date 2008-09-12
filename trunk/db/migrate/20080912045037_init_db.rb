class InitDb < ActiveRecord::Migration
  def self.up
    create_table "deleted_items", :force => true do |t|
      t.text     "name"
      t.text     "address"
      t.text     "tel"
      t.text     "email"
      t.text     "fax"
      t.text     "desc"
      t.float    "lat"
      t.float    "lng"
      t.integer  "quantity",   :limit => 11
      t.boolean  "processed"
      t.boolean  "is_checked"
      t.datetime "deleted_at"
      t.string  "uuid"
    end

    create_table "friends", :force => true do |t|
      t.text    "name"
      t.text    "twitter"
      t.text    "gtalk"
      t.text    "address"
      t.text    "tel"
      t.text    "email"
      t.text    "fax"
      t.text    "desc"
      t.float   "lat"
      t.float   "lng"
      t.integer "quantity", :limit => 11
      t.string  "uuid"
    end

    create_table "items", :force => true do |t|
      t.text    "name"
      t.text    "address"
      t.text    "tel"
      t.text    "email"
      t.text    "fax"
      t.text    "desc"
      t.float   "lat"
      t.float   "lng"
      t.integer "quantity",   :limit => 11
      t.boolean "processed"
      t.boolean "is_checked",               :default => false
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

  def self.down
  end
end
