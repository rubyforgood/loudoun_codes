require 'submission_runners'

class RunSubmissionJob < ApplicationJob
  queue_as :default

  def perform(submission_id)
    submission        = Submission.find_by_id!(submission_id)
    submission_result = submission.submission_results.create!
    problem           = submission.problem

    runner = SubmissionRunners.runner_for_submission(submission)
    runner.call

    if runner.run_succeeded?
      # FIXME: is this ok in general?
      if problem.output.strip == runner.output.strip
        submission.status             = "passed"
        submission_result.output      = runner.output
        submission_result.output_type = runner.output_type
      else
        submission.status             = "failed"
        submission_result.output      = "output didn't match"
        submission_result.output_type = "comparison_failure"
      end
    else
      submission.status             = "failed"
      submission_result.output      = runner.output
      submission_result.output_type = runner.output_type
    end

    submission_result.save!

    submission.save!
  end
end
