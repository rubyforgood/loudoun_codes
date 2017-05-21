require 'tty/command'

module SubmissionRunners
  class Base
    attr_reader :submission, :errors
    attr_accessor :result

    def initialize(submission)
      @submission = submission
      @errors     = {}
    end

    def call
      run_phase(:build) && run_phase(:run)
    end

    private

    def run_phase(phase)
      result = send(phase)

      if result.failed?
        errors[phase] = result.err
      end

      result.success?
    end

    def docker_run(*command, **options)
      command = [
        "docker", "run",
        "--name", container,
        "--volume", "#{submission_dir}:/workspace",
        "--workdir", "/workspace",
        "--user", container_user,
        "--rm",
        "--attach", "STDIN",
        "--attach", "STDOUT",
        "--attach", "STDERR",
        "--interactive",
        self.class.image,
        *command,
      ]

      options.merge!({
        timeout: problem_timeout,
      })

      TTY::Command.
        new(printer: :null).
        run!(*command, **options)
    end

    def submission_dir
      submission.uploaded_files_dir
    end

    def problem_timeout
      submission.problem_timeout || 30.seconds
    end

    def source_file
      submission.source_file
    end

    def input_file
      submission.problem_input_file
    end

    def container_user # should probably be overrideable, but this is a good default
      "nobody"
    end

    def container
      "#{self.class.name.demodulize.underscore}-#{submission.id}"
    end
  end
end
