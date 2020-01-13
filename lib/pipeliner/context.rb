require "ostruct"

module Pipeliner
  class Context < OpenStruct
    def self.build(context = {})
      self === context ? context : new(context)
    end

    def success?
      !failure?
    end

    def failure?
      @failure || false
    end

    def fail!(error)
      self.error = error
      @failure = true
    end
  end
end
