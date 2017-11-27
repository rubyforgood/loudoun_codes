# -*- coding: utf-8 -*-
require 'submission_runners/base'

module SubmissionRunners
  class Java < Base
    def self.image
      "java:8"
    end

    private

    def build
      docker_run("javac", source_file)
    end

    def run
      java_class = source_file.without_extension

      docker_run("java", java_class)
    end
  end
end
