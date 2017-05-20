class TeamScoreService
  def initialize(contest:)
    @contest = contest
  end

  def call(team:)
    team.submissions.where(status: 'passed', problem: @contest.problems).count
  end
end
