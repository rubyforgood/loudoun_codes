require 'stringio'

module SubmissionRunners
  class Base
    attr_reader :submission, :errors

    def initialize(submission)
      @submission = submission
      @errors     = {}
      @output     = ""
    end

    def submission_dir
      submission.uploaded_files_dir
    end

    def build_container
      "#{self.class.name.demodulize}_build"
    end

    def run_container
      "#{self.class.name.demodulize}_run"
    end    
  end
end
