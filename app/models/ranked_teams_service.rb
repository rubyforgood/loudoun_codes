class RankedTeamsService
  def initialize(teams: , contest:)
    @teams = teams
    @contest = contest
  end

  def  call
    team_score_service = TeamScoreService.new(contest: @contest)
    team_time_service = TeamTimeService.new(contest: @contest)

    @teams.sort do |team_1, team_2|
      [team_score_service.call(team: team_2),
       team_time_service.call(team: team_1)] <=>
        [team_score_service.call(team: team_1),
         team_time_service.call(team: team_2)]
    end
  end
end
