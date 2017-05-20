module Admin
  class ProblemsController < ApplicationController
    def new
      @contest = Contest.instance
      @problem = @contest.problems.build
    end

    def create
      @contest = Contest.instance
      @problem = @contest.problems.create problem_parameters

      uploaded_io = params[:problem][:attachment_ids]

      if uploaded_io
        attachment = @problem.attachments.create(original_filename: uploaded_io.original_filename,
                                                  content_type:      uploaded_io.content_type)

        attachment.with_file('w') do |file|
          file.write(uploaded_io.read)
        end
      end

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
