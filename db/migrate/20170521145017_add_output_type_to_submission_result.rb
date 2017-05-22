class AddOutputTypeToSubmissionResult < ActiveRecord::Migration[5.1]
  def change
    add_column :submission_results, :output_type, :string
  end
end
