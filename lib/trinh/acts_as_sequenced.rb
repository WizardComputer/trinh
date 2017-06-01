require 'active_support/core_ext/hash/slice'
require 'active_support/core_ext/class/attribute_accessors'

module Trinh
  module ActsAsSequenced
    TriedColumnExists = Class.new(StandardError)

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def acts_as_sequenced(options = {})
        unless defined?(sequenced_options)
          include Trinh::ActsAsSequenced::InstanceMethods

          mattr_accessor :sequenced_options, instance_accessor: false
          self.sequenced_options = []
        end

        column_name = options[:column]

        if sequenced_options.any? {|options| options[:column] == column_name}
          raise(TrinhColumnExists, <<-MSG.squish)
            Tried to set #{column_name} as sequenced but there was already a
            definition here. Did you accidentally call acts_as_sequenced
            multiple times on the same column?
          MSG
        else
          sequenced_options << options
        end
      end
    end

    module InstanceMethods
      def next_number
        options = self.class.base_class.sequenced_options.first
        Trinh::Generator.new(self, options).set
      end
    end
  end
end
