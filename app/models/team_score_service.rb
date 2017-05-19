class TeamScoreService
  def initialize(contest:, team:)
    @contest = contest
    @team = team
  end

  def call
    @team.submissions.where(passed: true, problem: @contest.problems).count
  end
end
