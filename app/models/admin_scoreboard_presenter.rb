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
end
