require_relative 'omni_builder'

module Docker
  class PythonBuilder < OmniBuilder
    def initialize(*args)
      @language_executable = '/usr/local/bin/python'
      super
    end

    def language_executable
      @language_executable
    end
  end
end
