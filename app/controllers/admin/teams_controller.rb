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
  end
end
