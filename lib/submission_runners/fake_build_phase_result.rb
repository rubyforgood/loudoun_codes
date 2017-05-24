module SubmissionRunners
  class FakeBuildPhaseResult
    def success?
      true
    end

    def failure?
      !success?
    end

    def out
      ""
    end

    def err
      ""
    end
  end
end
