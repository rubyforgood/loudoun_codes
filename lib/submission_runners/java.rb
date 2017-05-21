# -*- coding: utf-8 -*-
require 'submission_runners/base'

module SubmissionRunners
  class Java < Base
    def self.image
      "java:8"
    end

    private

    def build
      submission_dir.chmod(0777) # otherwise the nobody user doesn't have write permissions

      docker_run("javac", source_file.basename.to_s)
    end

    def run
      docker_run("java", java_class, chdir: submission_dir, in: input_buffer)
    end

    def java_class
      source_file.basename.to_s.gsub(
        /#{source_file.extname}$/,
        ""
      )
    end
  end
end
