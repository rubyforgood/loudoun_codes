# -*- coding: utf-8 -*-
require 'submission_runners/base'

module SubmissionRunners
  class Ruby < Base
    def self.image
      'ruby:2.4.1'
    end

    def run
      docker_run('ruby', source_file)
    end
  end
end
