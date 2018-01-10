# -*- coding: utf-8 -*-
require 'submission_runners/base'

module SubmissionRunners
  class placeholder.class_name < Base
    def self.image
    end

    private

    # def build
    #   docker_run
    # end

    def run
      docker_run("placeholder.language_name", source_file)
    end
  end
end
