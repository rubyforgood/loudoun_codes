# -*- coding: utf-8 -*-
require 'submission_runners/base'

module SubmissionRunners
  class Python < Base
    def self.image
      'python:3.6.1'
    end

    def run
      docker_run('python', source_file)
    end
  end
end
