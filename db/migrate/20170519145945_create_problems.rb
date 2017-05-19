class CreateProblems < ActiveRecord::Migration[5.1]
  def change
    create_table :problems do |t|
      t.string :name
      t.text :description
      t.references :contest

      t.timestamps
    end
  end
end
