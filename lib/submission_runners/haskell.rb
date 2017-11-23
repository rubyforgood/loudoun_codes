# -*- coding: utf-8 -*-
require 'submission_runners/base'
require 'fileutils'
require_relative '../../lib/docker/helpers'

module SubmissionRunners
  class Haskell < Base
    attr_reader :entry
    include Docker::Helpers

    def self.image
      "haskell:8.2"
    end

    def build
      FileUtils.chmod 0777, submission_dir

      @entry = EntryFile(source_file)
      docker_run("ghc", entry.filename, chdir: submission_dir)
    end

    def run
      docker_run("./#{entry.basename}", chdir: submission_dir, in: input_buffer)
    end
  end
end
