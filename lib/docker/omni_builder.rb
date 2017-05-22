module Docker
  class OmniBuilder
    delegate_missing_to :@runner
    include Docker::Helpers
    def initialize(runner)
      @runner = runner
    end

    def build
      temp_file_block(
        Entry(source_file),
        Input(input_buffer),
        submission_dir
      ) do |entry, input|
        @result = docker_run [
          language_executable,
          entry,
          '<',
          input,
        ], chdir: submission_dir
      end
    end

    def run
      temp_file_block(
        Result(@result),
        Output(output_file),
        submission_dir
      ) do |result, output|
        docker_run %W[cat #{result} | diff -w #{output} -], chdir: submission_dir
      end
    end

    def language_executable
      raise "#{self} - #{__method__} not implemented"
    end

    private def temp_file_block(file1, file2, dir)
      filename = ->file{ file.path.rpartition('/').last }

      Tempfile.open([file1.basename, file1.extname], dir) do |one|
        Tempfile.open([file2.basename, file2.extname], dir) do |two|
          one.write(file1.read)
          one.rewind
          two.write(file2.read)
          two.rewind
          Dir.chdir(dir) { yield filename.(one), filename.(two) }
        end
      end
    end
  end
end
