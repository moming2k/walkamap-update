class AddLocationIdToRegion < ActiveRecord::Migration
  def self.up
    add_column :regions, :location, :integer
  end

  def self.down
    remove_column :regions, :column_name
  end
end
