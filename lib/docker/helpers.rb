
module Docker
  module Helpers
    [:Entry, :Input, :Result, :Output].each do |type|
      eval <<-METHOD_DEF
        def #{type}(arg)
          return arg if arg.is_a? #{type}
          if File.exist? arg.to_s
            #{type}.new(arg)
          else
            #{type}.create(arg)
          end
        end
      METHOD_DEF
    end
  end
end
