class AddDeletableToItem < ActiveRecord::Migration
  def self.up
    Item::Deleted.create_table
  end

  def self.down
    Item::Deleted.drop_table
  end
end
