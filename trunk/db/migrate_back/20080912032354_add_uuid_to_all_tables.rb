class AddUuidToAllTables < ActiveRecord::Migration
  def self.up
    add_column :regions, :uuid, :string
    add_column :items, :uuid, :string
    add_column :friends, :uuid, :string
  end

  def self.down
    remove_column :regions, :uuid
    remove_column :items, :uuid
    remove_column :friends, :uuid
  end
end
