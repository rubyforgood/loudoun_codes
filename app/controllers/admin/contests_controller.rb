module Admin
  class ContestsController < AdminController
    def show
      @contest = Contest.instance
    end
  end
end
