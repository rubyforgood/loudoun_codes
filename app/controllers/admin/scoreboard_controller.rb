module Admin
  class ScoreboardController < AdminController
    def show
      @presenter = AdminScoreboardPresenter.new
    end
  end
end
