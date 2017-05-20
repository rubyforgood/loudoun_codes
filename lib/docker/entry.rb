require_relative('io_file')
module Docker
  class Entry < IOFile
    def docker_path
      "/solution/#{File.basename(path)}"
    end
  end
end
