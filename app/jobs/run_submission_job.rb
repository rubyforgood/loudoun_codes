class RunSubmissionJob < ApplicationJob
  queue_as :default

  def perform(submission_id)
    submission = Submission.find_by_id(submission_id)
    # Run the submission inside docker
    submission.submission_results.create!
  end
end
