require 'rails_helper'

RSpec.feature 'Team scoreboard', type: :feature do
  include_context "an authorized team"

  # let(:contest) { Contest.create!(started_at: Time.now) }

  scenario 'team scoreboard is accessible to team' do
    visit team_contest_scoreboard_path(team)

    expect(current_path).to eq(team_contest_scoreboard_path(team))
  end

  # scenario 'team scoreboard is not accessible to other teams' do
  #   team_2 = Team.create!(contest: Contest.instance, name: 'Team 2')

  #   visit team_contest_scoreboard_path(team)

  #   expect(current_path).to eq(root_path)
  # end

  scenario 'team scoreboard shows the problem status for pending submissions' do
    problem = Problem.create!(contest: Contest.instance)
    Submission.create!(problem: problem, team: team, status: 'pending')

    visit team_contest_scoreboard_path(team)

    within('tbody') do
      expect(page).to have_text('pending')
    end
  end

  scenario 'team scoreboard shows the problem status for failed submissions' do
    problem = Problem.create!(contest: Contest.instance)
    Submission.create!(problem: problem, team: team, status: 'failed')

    visit team_contest_scoreboard_path(team)

    within('tbody') do
      expect(page).to have_text('failed')
    end
  end

  scenario 'team scoreboard shows the problem status for passed submissions' do
    problem = Problem.create!(contest: Contest.instance)
    Submission.create!(problem: problem, team: team, status: 'passed')

    visit team_contest_scoreboard_path(team)

    within('tbody') do
      expect(page).to have_text('passed')
    end
  end
end
