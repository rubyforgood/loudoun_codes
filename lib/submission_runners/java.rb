# -*- coding: utf-8 -*-
require 'stringio'
require 'submission_runners/base'

module SubmissionRunners
  class Java < Base
    def image
      "java:8"
    end

    private

    def build
      submission_dir.chmod(0777) # otherwise the nobody user doesn't have write permissions

      docker_run("javac", source_file.basename)
    end

    def run
      docker_run("java", java_class, chdir: submission_dir, in: input_buffer)
    end

    def container_user
      "nobody"
    end

    def java_class
      submission.problem_name
    end
  end
end
