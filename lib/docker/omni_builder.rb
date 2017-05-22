module Docker
  class OmniBuilder
    include Docker::Helpers
    delegate_missing_to :@runner
    def initialize(runner)
      @runner = runner
    end

    def build
      @input ||= Input(input_file).filename
      @output ||= Output(output_file).filename
      entry ||= Entry(source_file, submission_dir).subpath
      @result = docker_run [
        language_executable,
        entry,
        '<',
        input,
      ], chdir: submission_dir
    end

    def run
      docker_run %W[echo "#{@result}" | diff -w "#{output}" -], chdir: submission_dir
    end

    private def input
      @input
    end

    private def output
      @output
    end

    def language_executable
      raise "#{self} - #{__method__} not implemented"
    end
  end
end
