require 'tty/command'

require 'submission_runners/source_file'
require 'submission_runners/fake_build_phase_result'

module SubmissionRunners
  class Base
    attr_reader :submission, :output, :output_type

    def initialize(submission)
      @submission = submission
    end

    def call
      submission_dir.chmod(0777) # otherwise the nobody user doesn't have write permissions

      run_phase(:build) && run_phase(:run)
    end

    def run_succeeded?
      !!run_succeeded
    end

    private

    attr_reader :current_phase, :run_succeeded

    def run_phase(phase)
      @current_phase = phase.to_sym

      result = send(phase)

      if result.success?
        @output        = result.out
        @output_type   = "success"
        @run_succeeded = true
      elsif result.failed?
        @output        = result.err
        @output_type   = "#{phase}_failure"
        @run_succeeded = false
      end

      result.success?
    end

    def build
      FakeBuildPhaseResult.new
    end

    def docker_run(*command, **options)
      whole_command = [
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
        *command.map(&:to_s),
      ]

      command_options = current_default_docker_run_options.
        merge(options).
        merge(timeout: problem_timeout)

      TTY::Command.
        new(printer: :null).
        run!(*whole_command, **command_options)
    end

    def current_default_docker_run_options
      {
        build: {},
        run:   {
          chdir: submission_dir,
          in:    input_buffer,
        },
      }[current_phase]
    end

    def submission_dir
      submission.uploaded_files_dir
    end

    def problem_timeout
      submission.problem_timeout || 30.seconds
    end

    def source_file
      SourceFile.new(submission.source_file.basename)
    end

    def input_buffer
      submission.problem_input_buffer
    end

    def container_user # should probably be overrideable, but this is a good default
      "nobody"
    end

    def container
      "#{self.class.name.demodulize.underscore}-#{submission.id}"
    end
  end
end
