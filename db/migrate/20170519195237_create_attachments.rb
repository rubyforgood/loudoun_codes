class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.string :original_filename
      t.string :content_type
      t.integer :attachable_id
      t.string :attachable_type

      t.timestamps
    end

    add_index :attachments, [:attachable_type, :attachable_id]
  end
end
