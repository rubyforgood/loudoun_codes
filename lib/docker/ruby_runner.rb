require_relative 'omni_runner'

module Docker
  class RubyRunner < OmniRunner
    def initialize(workdir)
      @language_executable = '/usr/local/bin/ruby'
      @docker_image = 'ruby'
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
