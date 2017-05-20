# -*- coding: utf-8 -*-
require 'stringio'
require 'submission_runners/base'

module SubmissionRunners
  class Java < Base
    def call
      build
      run
    end

    def image
      "java:8"
    end

    private

    def build
      `chmod -R 0777 #{submission_dir.to_s}`

      options = [
        "--name #{build_container}",
        "--volume #{submission_dir}:/workspace",
        "--workdir /workspace",
        "--user nobody",
        "--rm",
      ].join(" ")

      run_command(
        "docker run #{options} #{image} javac #{source_file.basename}"
      )
    end

    def run
      options = [
        "--name #{run_container}",
        "--volume #{submission_dir}:/workspace",
        "--workdir /workspace",
        "--user nobody",
        "--rm",
        "--attach STDIN",
        "--attach STDOUT",
        "--interactive",
      ].join(" ")

      input = StringIO.new
      input.write(input_file.read)

      run_command(
        "docker run #{options} #{image} java #{java_class}",
        timeout: problem_timeout,
        chdir: submission_dir,
        in: input.tap(&:rewind),
      )
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
