module Admin
  class ScoreboardController < AdminController
    def show
      @contest = Contest.instance
      @teams = RankedTeamsService.new(contest: @contest).call
    end
  end
end
