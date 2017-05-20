module Admin
  class ScoreboardController < AdminController
    def show
      @contest = Contest.instance
      @teams = RankedTeamsService.new(contest: @contest).call
    end

    private

    def scoreboard_params
      params.permit(:logged_in)
    end
  end
end
