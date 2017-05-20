require_relative 'omni_builder'

module Docker
  class RubyBuilder < OmniBuilder
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
