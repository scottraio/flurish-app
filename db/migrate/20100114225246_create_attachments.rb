class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :attachments
  end
end
