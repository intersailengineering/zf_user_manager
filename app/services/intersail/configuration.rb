module Intersail
  module Configuration
    class << self
      def config
        @config ||= Intersail::ConfigurationOptions.new
      end

      def configure
        yield(config) if block_given?
      end
    end
  end
end
