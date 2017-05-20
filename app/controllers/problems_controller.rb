class ProblemsController < ApplicationController
  def index
    @problems = Problem.all.map do |problem|
      ProblemPresenter.new(problem)
    end
  end

  def show
    @contest = Contest.instance
    @problem = @contest.problems.find(params[:id])
  end
end
