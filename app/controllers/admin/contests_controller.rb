module Admin
  class ContestsController < ApplicationController
    def show
      @contest = Contest.instance
    end
  end
end
