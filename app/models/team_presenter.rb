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
end
