# frozen_string_literal: true

module Kobana
  module Middleware
    class RaiseError < Faraday::Response::Middleware
      def on_complete(env)
        status = env[:status].to_i
        is_error = (400..599).cover?(status)

        raise Kobana::Error, env if is_error && env.body["errors"]
      end
    end
  end
end
