# -*- coding: utf-8 -*-
require 'submission_runners/base'
require_relative '../../lib/docker/helpers'

module SubmissionRunners
  class Cpp < Base
    attr_reader :entry
    include Docker::Helpers

    def self.image
      "gcc:7.1"
    end

    def build
      @entry = EntryFile(source_file)
      docker_run("g++", "-o", entry.basename, entry.filename, chdir: submission_dir)
    end

    def run
      docker_run("./#{entry.basename}")
    end
  end
end
