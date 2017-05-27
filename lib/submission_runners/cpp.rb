# -*- coding: utf-8 -*-
require 'submission_runners/base'

module SubmissionRunners
  class Cpp < Base
    def self.image
      "gcc:7.1"
    end

    private

    def build
      docker_run("g++", "-o", executable, source_file)
    end

    def run
      docker_run("./#{executable}")
    end

    def executable
      source_file.without_extension
    end
  end
end
