class AddcheckedToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :is_checked, :boolean , :default => false
  end

  def self.down
    remove_column :items, :is_checked
  end
end
