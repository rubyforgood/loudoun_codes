class SubmissionsController < ApplicationController
  def new
    @submission = Submission.new
  end

  def create
    submission = params.require :submission
    @submission = Submission.new(
      problem_id: submission[:problem],
      team:       current_team,
    )

    if submission[:attachment]
      attachment = Attachment.new(
        original_filename: submission[:attachment].original_filename,
        attachment_type: 'solution'
      )
      @submission.attachment = attachment
      attachment.attachable = @submission
    end

    @submission.transaction do
      if @submission.save
        attachment.with_file('wb') do |file|
          file.write submission[:attachment].read
        end

        RunSubmissionJob.perform_later @submission.id

        redirect_to @submission
      else
        flash.now.alert = 'Problem with submission, see below for details.'
        render 'new'
      end
    end
  end

  def show
    @submission = Submission.find params[:id]
  end

  def current_team
    # TODO: Team auth
    Contest.instance.teams.first
  end
  helper_method :current_team
end
