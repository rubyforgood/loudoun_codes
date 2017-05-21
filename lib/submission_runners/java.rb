# -*- coding: utf-8 -*-
require 'stringio'
require 'submission_runners/base'

module SubmissionRunners
  class Java < Base
    def call
      build && run
    end

    def image
      "java:8"
    end

    private

    def build
      submission_dir.chmod(0777) # otherwise the nobody user doesn't have write permissions

      command_pieces = [
        "docker", "run",
        "--name", build_container,
        "--volume", "#{submission_dir}:/workspace",
        "--workdir", "/workspace",
        "--user", container_user,
        "--rm",
        "--attach", "STDOUT",
        "--attach", "STDERR",
        "--interactive",
        image,
        "javac", source_file.basename
      ]

      run_command(
        :build,
        command_pieces,
        timeout: problem_timeout
      )
    end

    def run
      command_pieces = [
        "docker", "run",
        "--name", run_container,
        "--volume", "#{submission_dir}:/workspace",
        "--workdir", "/workspace",
        "--user", container_user,
        "--rm",
        "--attach", "STDIN",
        "--attach", "STDOUT",
        "--attach", "STDERR",
        "--interactive",
        image,
        "java", java_class
      ]

      input = StringIO.new

      input.write(input_file.read)
      input.rewind

      run_command(
        :run,
        command_pieces,
        timeout: problem_timeout,
        chdir: submission_dir,
        in: input,
      )
    end

    def container_user
      "nobody"
    end

    def source_file
      submission.source_file
    end

    def input_file
      submission.problem_input_file
    end

    def java_class
      submission.problem_name
    end
  end
end
