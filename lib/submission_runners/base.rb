require 'tty/command'

module SubmissionRunners
  class Base
    attr_reader :submission, :errors
    attr_accessor :result

    def initialize(submission)
      @submission = submission
      @errors     = {}
    end

    def submission_dir
      submission.uploaded_files_dir
    end

    def problem_timeout
      submission.problem_timeout || 30.seconds
    end

    def run_command(phase, command_pieces, **options)
      begin
        self.result = TTY::Command.
          new(printer: :null).
          run(*command_pieces, **options)
      rescue TTY::Command::ExitError => error
        errors[phase] = error
      end

      errors.empty?
    end

    def container
      "#{self.class.name.demodulize.underscore}-#{submission.id}"
    end
  end
end
