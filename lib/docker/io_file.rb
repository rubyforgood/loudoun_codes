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

    attr_reader :basename
    def initialize(path)
      raise "Pathname object expected" unless path.is_a? Pathname # enforce type
      @basename = path.basename(path.extname).to_s
      @path = path.to_s
    end

    def docker_path
      raise "not implemented"
    end

    def path
      @path
    end

    def docker_map
      local = path.rpartition('/').shift(2).join
      docker = docker_path.rpartition('/').shift(2).join
      "#{local}:#{docker}"
    end
  end
end
