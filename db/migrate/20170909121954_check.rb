class Check < ActiveRecord::Migration[5.1]
  def change
    remove_index :attachments, :attachmentable_type
    remove_column :attachments, :attachmentable_type, :string
    remove_index :attachments, :attachmentable_id
    remove_column :attachments, :attachmentable_id
  end
end
