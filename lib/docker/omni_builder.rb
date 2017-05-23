module Docker
  class OmniBuilder
    delegate_missing_to :@runner
    include Docker::Helpers
    include Support::TempFileBlock
    def initialize(runner)
      @runner = runner
    end

    def run
      temp_file_block(EntryFile(source_file), submission_dir) do |entry|
        docker_run \
          language_executable,
          filename(entry),
          chdir: submission_dir,
          in: input_buffer
      end
    end

    def language_executable
      raise "#{self} - #{__method__} not implemented"
    end

    private def filename(io_file)
      io_file.path.rpartition('/').last
    end
  end
end
