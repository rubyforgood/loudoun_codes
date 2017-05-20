# inherited for Input and Output classes
module Docker
  class IOFile
    def self.create(abs_path_file, source)
      raise 'Absolute path require for file' unless abs_path_file.to_s[0..0] == '/'
      dir, * = abs_path_file.rpartition('/')
      FileUtils.mkdir_p dir
      File.open(abs_path_file, 'w') {|file| file.write(source) }
      new Pathname.new(abs_path_file)
    end

    attr_reader :basename, :dirname
    def initialize(path)
      path = Pathname.new path
      @basename = path.basename(path.extname).to_path
      @dirname = path.dirname.to_path
      @path = path.to_path
    end

    def path
      @path
    end
  end
end
