module Admin
  class ScoreboardController < AdminController
    def show
      @contest = Contest.instance
      @teams = RankedTeamsService.new(contest: @contest, teams: active_teams).call
    end

    private

    def active_teams
      ActiveTeamsService.new(contest: @contest, teams: @contest.teams).call
    end
  end
end
