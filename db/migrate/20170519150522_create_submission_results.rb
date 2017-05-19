class CreateSubmissionResults < ActiveRecord::Migration[5.1]
  def change
    create_table :submission_results do |t|
      t.text :output
      t.references :submission, foreign_key: true

      t.timestamps
    end
  end
end
