class TeamPresenter
  def initialize(team:)
    @team = team
  end

  def problem_status(problem)
    if problem.submissions.where(account: @team, status: 'passed').any?
      'passed'
    elsif problem.submissions.where(account: @team, status: 'pending').any?
      'pending'
    elsif problem.submissions.where(account: @team, status: 'failed').any?
      'failed'
    else
      ''
    end
  end

  def color(problem)
    if problem_status(problem) == 'passed'
      return 'lightgreen'
    elsif problem_status(problem) == 'pending'
      return 'yellow'
    elsif  problem_status(problem) == 'failed'
      return 'orange'
    end
  end

  def time_elapsed(problem)
    if passed_submissions(problem).any?
      Time.at(time_elapsed_in_minutes(problem)).strftime("%H:%M:%S")
    else
      ''
    end
  end

  def attempts(problem)
    ProblemAttemptsService.new(problem: problem, account: @team).call
  end

  private

  def time_elapsed_in_minutes(problem)
    (first_passed_submission(problem).created_at - Contest.instance.started_at).seconds
  end

  def submissions(problem)
    @team.submissions.where(problem: problem)
  end

  def passed_submissions(problem)
    submissions(problem).where(status: 'passed')
  end

  def first_passed_submission(problem)
    passed_submissions(problem).first
  end

end
