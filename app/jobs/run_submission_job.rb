require 'submission_runners'

class RunSubmissionJob < ApplicationJob
  queue_as :default

  def perform(submission_id)
    submission = Submission.find_by_id!(submission_id)
    runner     = SubmissionRunners.runner_for_submission(submission)

    submission_result = SubmissionResult.create!({
      submission_id: submission.id,
    })

    runner.call

    if runner.run_succeeded?
      submission_result.passed = true
    else
      runner.errors.each do |runner_phase, error|
        SubmissionResultNotification.create!({
          submission_result_id: submission_result.id,
          runner_phase:         runner_phase.to_s,
          message:              error.message,
        })
      end
    end

    submission_result.save!
  end
end
