class CreateSubRegion2s < ActiveRecord::Migration
  def self.up
    create_table :sub_region2s do |t|
      t.string :name
      t.integer :region_id

      t.timestamps
    end
  end

  def self.down
    drop_table :sub_region2s
  end
end