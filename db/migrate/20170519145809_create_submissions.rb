class CreateSubmissions < ActiveRecord::Migration[5.1]
  def change
    create_table :submissions do |t|
      t.boolean :passed
      t.references :team
      t.references :problem
      t.integer :runtime

      t.timestamps
    end
  end
end
