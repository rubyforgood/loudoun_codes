# -*- coding: utf-8 -*-
require 'submission_runners/base'
require 'fileutils'

module SubmissionRunners
  class Haskell < Base
    def self.image
      "haskell:8.2"
    end

    private

    def build
      docker_run("ghc", source_file)
    end

    def run
      docker_run("./#{executable}")
    end

    def executable
      source_file.without_extension
    end
  end
end
