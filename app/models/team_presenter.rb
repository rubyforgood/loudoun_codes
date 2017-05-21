class TeamPresenter
  def initialize(team:)
    @team = team
  end

  def problem_status(problem)
    if problem.submissions.where(team: @team, status: 'passed').any?
      'passed'
    elsif problem.submissions.where(team: @team, status: 'pending').any?
      'pending'
    elsif problem.submissions.where(team: @team, status: 'failed').any?
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


  def attempts(problem)
    ProblemAttemptsService.new(problem: problem, team: @team).call
  end

end
