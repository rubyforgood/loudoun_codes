require_relative 'omni_builder'

module Docker
  class RubyBuilder < OmniBuilder
    def initialize(*args)
      @language_executable = '/usr/local/bin/ruby'
      super
    end

    def language_executable
      @language_executable
    end
  end
end
