class CreateBookmarkTable < ActiveRecord::Migration
  def self.up
    create_table "bookmarks", :force => true do |t|
      t.text    "name"
      t.text    "address"
      t.string  "item_id"
    end
  end

  def self.down
    drop_table :bookmarks
  end
end
