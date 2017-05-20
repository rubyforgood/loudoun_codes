class AddTypeToAttachment < ActiveRecord::Migration[5.1]
  def change
    add_column :attachments, :attachment_type, :string
  end
end
