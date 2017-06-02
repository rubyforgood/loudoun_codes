# -*- coding: utf-8 -*-
require 'submission_runners/base'
require 'fileutils'
require_relative '../../lib/docker/helpers'
require_relative '../support/temp_file_block'

module SubmissionRunners
  class Crystal < Base
    attr_reader :entry
    include Docker::Helpers

    def self.image
      'crystallang/crystal:0.22.0'
    end

    def build
      @entry = EntryFile(source_file)
      CrystalBuildResponse.new \
        docker_run('crystal', 'build', '-o', entry.basename, entry.filename, chdir: submission_dir)
    end

    def run
      docker_run("./#{entry.basename}", chdir: submission_dir, in: input_buffer)
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
