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
      submission_dir.chmod(0777)

      puts "mode of #{submission_dir.to_s}: #{submission_dir.stat.mode.to_s(8)}"

      options = [
        "--name #{build_container}",
        "--volume #{submission_dir}:/workspace",
        "--workdir /workspace",
        "--user #{container_user}",
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
        "--user #{container_user}",
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
