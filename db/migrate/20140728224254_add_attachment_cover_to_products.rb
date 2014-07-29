class AddAttachmentCoverToProducts < ActiveRecord::Migration
  def self.up
    change_table :products do |t|
      t.attachment :cover
    end
  end

  def self.down
    remove_attachment :products, :cover
  end
end
