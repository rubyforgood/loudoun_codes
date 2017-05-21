class TeamsController < ApplicationController
  def show
    # redirect_to root_path if current_account.id != scoreboard_params[:id]
    @problems = Contest.instance.problems
    @presenter = TeamPresenter.new(team: team)
  end

  private

  def team
    Team.find(scoreboard_params[:id])
  end

  def scoreboard_params
    params.permit(:id)
  end
end
