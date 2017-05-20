require_relative('io_file')
module Docker
  class Output < IOFile
    def docker_path
      "/outputs/#{File.basename(path)}"
    end
  end
end
