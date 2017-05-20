require_relative 'omni_builder'

module Docker
  class PythonBuilder < OmniBuilder
    def initialize(workdir, debug = false)
      @language_executable = '/usr/local/bin/python'
      @docker_image = 'python'
      super
    end

    def docker_image
      @docker_image
    end

    def language_executable
      @language_executable
    end
  end
end
