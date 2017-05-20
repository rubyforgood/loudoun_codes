module Admin
  class ScoreboardController < AdminController
    def show
      @contest = Contest.instance
      @teams = RankedTeamsService.new(contest: @contest).call
      @problems = @contest.problems
    end
  end
end
