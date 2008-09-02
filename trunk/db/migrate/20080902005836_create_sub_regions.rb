class CreateSubRegions < ActiveRecord::Migration
  def self.up
    create_table :sub_regions do |t|
      t.string :name
      t.float :lat
      t.float :lng
      t.integer :region_id

      t.timestamps
    end
  end

  def self.down
    drop_table :sub_regions
  end
end
