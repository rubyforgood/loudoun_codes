# -*- coding: utf-8 -*-
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
      options = [
        "--name #{build_container}",
        "--volume #{submission_dir}:/workspace",
        "--workdir #{submission_dir}",
        "--user user",
        "--rm",
      ].join(" ")

      "docker run #{options} #{image} javac #{source_file.basename}"
    end

    def run
      options = [
        "--name #{build_container}",
        "--volume #{submission_dir}:/workspace",
        "--workdir #{submission_dir}",
        "--user user",
        "--rm",
        "--attach STDIN",
        "--attach STDOUT",
      ].join(" ")

      "docker run #{options} #{image} java #{java_class} < #{input_file}"
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
