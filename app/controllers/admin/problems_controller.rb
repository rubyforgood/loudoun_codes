module Admin
  class ProblemsController < ApplicationController
    def new
      @contest = Contest.instance
      @problem = @contest.problems.build
    end

    def create
      @contest = Contest.instance
      @problem = @contest.problems.create problem_parameters

      if @problem.valid?
        redirect_to admin_problem_path @problem
      else
        render action: 'new'
      end
    end

    def show
      @contest = Contest.instance
      @problem = @contest.problems.find(params[:id])
    end

  private

    def problem_parameters
      params.require(:problem).permit(:name, :description)
    end
  end
end
