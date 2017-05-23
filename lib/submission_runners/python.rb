# -*- coding: utf-8 -*-
require 'submission_runners/base'

module SubmissionRunners
  class Python < Base
    def self.image
      'python:3.6.1'
    end

    def initialize(*args)
      @python_builder = Docker::PythonBuilder.new(self)
      super
    end

    delegate :run, to: :@python_builder

    def build
      MockResult.new
    end

    def container_user
      "root"
    end

    class MockResult
      def success?; true end
      def failure?; false end
      def out; '' end
      def err; '' end
    end
  end
end
