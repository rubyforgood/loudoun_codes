class Admin::ScoreboardController < ApplicationController
  def show
    # TODO Update when authorization is in place
    redirect_to root_path unless params[:logged_in]
  end
end
