# frozen_string_literal: true

require "faraday_middleware"
require "faraday/detailed_logger"
require_relative "kobana/version"

module Kobana
  module Middleware
    autoload :RaiseError, "kobana/middlewares/raise_error"
  end

  # Core
  autoload :Error, "kobana/error"
  autoload :Configuration, "kobana/configuration"
  autoload :Client, "kobana/client"
  autoload :Resource, "kobana/resource"
  autoload :Object, "kobana/object"

  # Nice data objects
  autoload :PixObject, "kobana/objects/pix"

  # Resources
  autoload :PixResource, "kobana/resources/pix"

  def self.pix
    PixResource.new configuration.client
  end

  class << self
    def setup
      configuration.tap do |instance|
        yield(instance) if block_given?
        instance.setup_client
      end
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
end
