class ActiveTeamsService
  def initialize(contest:, teams:)
    @contest = contest
    @teams = teams
  end

  def call
    @teams.reject { |team| team.submissions.where(problem: @contest.problems).empty? }
  end
end
