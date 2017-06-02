# -*- coding: utf-8 -*-
require 'submission_runners/base'

module SubmissionRunners
  class Crystal < Base
    def self.image
      'crystallang/crystal:0.22.0'
    end

    def build
      CrystalBuildResponse.new \
        docker_run('crystal', 'build', '-o', executable, source_file)
    end

    def run
      docker_run("./#{executable}")
    end

    def executable
      source_file.without_extension
    end

    class CrystalBuildResponse
      delegate_missing_to :@result_object
      def initialize(result_object)
        @result_object = result_object
      end

      # def out
      #   return @result_object.out if exit_status.zero?
      #   @result_object.err
      # end

      def err
        return @result_object.err if exit_status.zero?
        @result_object.out
      end
    end
  end
end
