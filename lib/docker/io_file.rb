# inherited for Input and Output classes
module Docker
  class IOFile
    def self.create(abs_path_file, source)
      raise 'Absolute path require for file' unless abs_path_file.to_s[0..0] == '/'
      dir, * = abs_path_file.rpartition('/')
      FileUtils.mkdir_p dir
      File.open(abs_path_file, 'w') { |file| file.write(source) }
      new Pathname.new(abs_path_file)
    end

    attr_reader :basename, :dirname, :filename, :subpath
    def initialize(path, rootpath = nil)
      raise "path cannot be nil" unless path
      path = Pathname.new path
      @filename = path.basename.to_path
      @basename = path.basename(path.extname).to_path
      @dirname = path.dirname.to_path
      @path = path.to_path

      # If we're using a path below the docker mount point
      # then we need to provide that info for files in docker.
      @subpath = \
        Pathname.new(
          if rootpath.nil?
            filename
          else
            path().gsub(/#{rootpath}/, '')
          end
        ).to_path
    end

    def path
      @path
    end
    alias :to_path :path
  end
end
