require 'submission_runners'

class RunSubmissionJob < ApplicationJob
  queue_as :default

  def perform(submission_id)
    submission        = Submission.find_by_id!(submission_id)
    submission_result = submission.submission_results.create!

    runner = SubmissionRunners.runner_for_submission(submission)
    runner.call

    if runner.run_succeeded?
      submission.status = "passed"
    else
      submission.status = "failed"
    end

    submission_result.output_type = runner.output_type
    submission_result.output      = runner.output

    submission_result.save!

    submission.save!
  end
end
