module Admin
  class ContestsController < AdminController
    def show
      @contest = Contest.instance
    end

    def edit
      @contest = Contest.instance
    end

    def update
      @contest = Contest.instance

      if @contest.update contest_params
        redirect_to admin_contest_path
      else
        render :edit
      end
    end

    def start
      @contest = Contest.instance

      @contest.update_attributes started_at: Time.current.utc

      flash[:success] = "The contest has started"

      redirect_to admin_contest_path
    end

  private
    def contest_params
      params.require(:contest).permit(:name)
    end
  end
end
