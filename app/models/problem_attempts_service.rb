class ProblemAttemptsService
  def initialize(problem:, team:)
    @problem = problem
    @team = team
  end

  def call
    if passed?
      submissions.where("created_at <= ?", first_passed_submission.created_at).count
    else
      submissions.count
    end
  end

  private

  def submissions
    @team.submissions.where(problem: @problem)
  end

  def passed_submissions
    submissions.where(status: 'passed')
  end

  def passed?
    passed_submissions.any?
  end

  def first_passed_submission
    passed_submissions.first
  end
end
