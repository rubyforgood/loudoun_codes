module Admin
  class ProblemsController < ApplicationController
    ATTACHMENT_TYPES = %w(handout sample_in sample_out)

    def new
      @contest = Contest.instance
      @problem = @contest.problems.build

      @attachments = ATTACHMENT_TYPES.map do |type|
        Attachment.new(attachment_type: type)
      end
    end

    def create
      @contest = Contest.instance
      @problem = @contest.problems.build problem_parameters

      if @problem.save
        if params[:problem][:attachment]
          ATTACHMENT_TYPES.each do |type|
            add_attachment(params[:problem][:attachment][type], type)
          end
        end

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

      attachment = @problem.attachments.build(original_filename: io.original_filename,
                                              content_type:      io.content_type,
                                              attachment_type:   label)

      attachment.with_file('w') do |file|
        file.write(io.read)
      end

      attachment.save # save after writing in case something goes wrong
    end

    def problem_parameters
      params.require(:problem).permit(:name, :description)
    end
  end
end
