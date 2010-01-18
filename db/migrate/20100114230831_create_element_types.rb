class CreateElementTypes < ActiveRecord::Migration
  def self.up
    create_table :element_types do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :element_types
  end
end
