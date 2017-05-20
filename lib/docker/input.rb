require_relative('io_file')
module Docker
  class Input < IOFile
    def docker_path
      "/inputs/#{File.basename(path)}"
    end
  end
end
