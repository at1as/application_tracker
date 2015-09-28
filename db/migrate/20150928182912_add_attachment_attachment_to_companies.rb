class AddAttachmentAttachmentToCompanies < ActiveRecord::Migration
  def self.up
    change_table :companies do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :companies, :attachment
  end
end
