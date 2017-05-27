# -*- coding: utf-8 -*-
require 'submission_runners/base'

module SubmissionRunners
  class Cpp < Base
    def self.image
      "gcc:7.1"
    end

    def build
      docker_run("g++", "-o", source_file.without_extension, source_file, chdir: submission_dir)
    end

    def run
      docker_run("./#{source_file.without_extension}")
    end
  end
end
