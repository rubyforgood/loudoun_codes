module Admin
  class ScoreboardController < AdminController
    def show
      @contest = Contest.instance
      @teams = RankedTeamsService.new(contest: @contest, teams: active_teams).call
    end

    private

      def scoreboard_params
        params.permit(:contest_id, :logged_in)
      end

      def active_teams
        @contest.teams
      end
  end
end
