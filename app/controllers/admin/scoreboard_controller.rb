module Admin
  class ScoreboardController < AdminController
    def show
      @contest = Contest.find(scoreboard_params[:contest_id])
      @teams = RankedTeamsService.new(contest: @contest, teams: active_teams).call
    end

    private

      def scoreboard_params
        params.permit(:contest_id, :logged_in)
      end

      def active_teams
        ActiveTeamsService.new(contest: @contest, teams: @contest.teams).call
      end
  end
end
