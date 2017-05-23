module Docker
  module Helpers
    [:Entry, :Input, :Result, :Output].each do |type|
      eval <<-METHOD_DEF
        def #{type}File(arg, dir = nil)
          return arg if arg.is_a? #{type}File
          if File.exist? arg.to_s
            #{type}File.new(arg)
          else
            #{type}File.create(Tempfile.new('docker', dir || Dir.pwd).path, arg)
          end
        end
      METHOD_DEF
    end
  end
end
