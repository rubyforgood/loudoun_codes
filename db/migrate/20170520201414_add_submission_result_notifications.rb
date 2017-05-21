class AddSubmissionResultNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :submission_result_notifications do |t|
      t.string :runner_phase
      t.string :message
      t.references :submission_result, foreign_key: true

      t.timestamps
    end
  end
end
