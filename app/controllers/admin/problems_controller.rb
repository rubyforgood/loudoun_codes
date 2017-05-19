module Admin
  class ProblemsController < AdminController

    def new
      @contest = Contest.instance
      @problem = @contest.problems.build
    end

  end
end
