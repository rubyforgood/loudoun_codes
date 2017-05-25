require 'rails_helper'

RSpec.feature 'Team scoreboard', type: :feature do
  include_context "an authorized team"

  before { Contest.instance.start }

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

  scenario 'team scoreboard shows the number of attempts for each problem' do
    problem_1 = Problem.create!(contest: Contest.instance)
    problem_2 = Problem.create!(contest: Contest.instance)
    problem_3 = Problem.create!(contest: Contest.instance)

    4.times { Submission.create!(problem: problem_1, team: team, status: 'failed') }

    5.times { Submission.create!(problem: problem_2, team: team, status: 'failed') }
    Submission.create!(problem: problem_2, team: team, status: 'passed')
    Submission.create!(problem: problem_2, team: team, status: 'passed')

    6.times { Submission.create!(problem: problem_3, team: team, status: 'failed') }
    Submission.create!(problem: problem_3, team: team, status: 'passed')
    6.times { Submission.create!(problem: problem_3, team: team, status: 'failed') }

    visit team_contest_scoreboard_path(team)

    within('tbody') do
      expect(page).to have_text(4)
      expect(page).to have_text(6)
      expect(page).to have_text(7)
    end
  end
end
