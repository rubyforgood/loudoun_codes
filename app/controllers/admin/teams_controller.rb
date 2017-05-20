module Admin
  class TeamsController < AdminController
    def index
      @contest = Contest.instance
      @teams   = @contest.teams
    end

    def new
      @contest  = Contest.instance
      @team     = @contest.teams.build
    end

    def create
      @contest  = Contest.instance
      @team     = @contest.teams.build team_params.merge(password: TokenPhrase.generate)

      if @team.save
        redirect_to admin_teams_path
      else
        render action: 'new'
      end
    end

  private

    def team_params
      params.require(:team).permit(:name, :username)
    end
  end
end
