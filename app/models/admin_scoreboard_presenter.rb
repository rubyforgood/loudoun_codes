class AdminScoreboardPresenter
  attr_reader :ranked_teams, :problems

  def initialize
    @contest = Contest.instance
    @ranked_teams = RankedTeamsService.new(contest: @contest).call
    @problems = @contest.problems
  end

  def attempts(team:, problem:)
    ProblemAttemptsService.new(problem: problem, team: team).call
  end

  def score(team:)
    TeamScoreService.new(contest: Contest.instance).call(team: team)
  end

  def time_plus_penalty(team:)
    Time.at(TeamTimeService.new(contest: Contest.instance).call(team: team)).utc.strftime('%H:%M:%S')
  end

  def color(team:, problem:)
    if problem.submissions.where(team: team, status: 'passed').any?
      return 'lightgreen'
    elsif problem.submissions.where(team: team, status: 'pending').any?
      return 'yellow'
    elsif problem.submissions.where(team: team, status: 'failed').any?
      return 'orange'
    end
  end
end
