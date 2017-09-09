class Retry < ActiveRecord::Migration[5.1]
  def change
    add_reference :attachments, :attachmentable, polymorphic: true, index: true
  end
end
