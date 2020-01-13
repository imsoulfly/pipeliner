require "pipeliner/version"
require "pipeliner/context"

module Pipeliner
  class Error < StandardError; end
  # Your code goes here...

  module Pipeline
    def self.included(base)
      base.class_eval do
        extend ClassMethods
        include InstanceMethods

        attr_reader :context
      end
    end

    module ClassMethods
      def call(context = {})
        new(context).tap(&:run).context
      end

      def pipeline(*interactors)
        @pipelined = interactors.flatten
      end

      def pipelined
        @pipelined ||= []
      end
    end

    module InstanceMethods
      def run
        self.class.pipelined.each do |action|
          break if context.failure?

          self.send(action, context)
        end
      end

      def fail!(error)
        context.fail!(error)
      end
    end

    def initialize(context = {})
      @context = Context.build(context)
    end
  end
end
