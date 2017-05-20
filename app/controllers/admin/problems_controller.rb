module Admin
  class ProblemsController < ApplicationController
    def new
      @contest = Contest.instance
      @problem = @contest.problems.build
    end

    def create
      @contest = Contest.instance
      @problem = @contest.problems.build problem_parameters

      if @problem.save
        add_attachment(params[:problem][:handout], 'handout')
        add_attachment(params[:problem][:sample_in], 'sample_in')
        add_attachment(params[:problem][:sample_out], 'sample_out')

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

    def add_attachment(io, label)
      return unless io

      attachment = @problem.attachments.create(original_filename: io.original_filename,
                                               content_type:      io.content_type,
                                               attachment_type:   label)

      attachment.with_file('w') do |file|
        file.write(io.read)
      end
    end

    def problem_parameters
      params.require(:problem).permit(:name, :description)
    end
  end
end
