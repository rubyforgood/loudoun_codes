require 'pathname'

module SubmissionRunners
  class SourceFile < Pathname
    def without_extension
      sub(/#{extname}$/, "")
    end
  end
end
