# frozen_string_literal: true

require "ostruct"

module Kobana
  class Object < OpenStruct
    def initialize(attributes)
      super to_ostruct(attributes)
    end

    def to_ostruct(obj)
      if obj.is_a?(Hash)
        OpenStruct.new(obj.transform_values { |val| to_ostruct(val) })
      else # Assumed to be a primitive value
        obj
      end
    end
  end
end
