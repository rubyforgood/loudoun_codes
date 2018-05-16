# -*- coding: utf-8 -*-
require 'submission_runners/base'
require 'fileutils'

module SubmissionRunners
  class Rust < Base
    def self.image
      "rust:1.26.0"
    end

    private

    def build
      docker_run("rustc", "-o", executable, source_file)
    end

    def run
      docker_run("./#{executable}")
    end

    def executable
      source_file.without_extension
    end
  end
end
