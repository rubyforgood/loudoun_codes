module Admin
  class ScoreboardController < ApplicationController
    def show
      # TODO Update when authorization is in place
      redirect_to root_path unless scoreboard_params[:logged_in]

      contest = Contest.find(scoreboard_params[:contest_id])
      @teams = ActiveTeamsService.new(contest: contest, teams: contest.teams).call
    end

    private

      def scoreboard_params
        params.permit(:contest_id, :logged_in)
      end
  end
end
