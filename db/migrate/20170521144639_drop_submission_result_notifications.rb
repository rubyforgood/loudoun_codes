class DropSubmissionResultNotifications < ActiveRecord::Migration[5.1]
  def change
    drop_table :submission_result_notifications
  end
end
