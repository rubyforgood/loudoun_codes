
module Docker
  module Helpers
    def Output(thing, rootdir = nil)
      return thing if thing.is_a? Output
      Output.new(thing, rootdir) 
    end

    def Input(thing, rootdir = nil)
      return thing if thing.is_a? Input
      Input.new(thing, rootdir)
    end

    def Entry(thing, rootdir = nil)
      return thing if thing.is_a? Entry
      Entry.new(thing, rootdir)
    end
  end
end
