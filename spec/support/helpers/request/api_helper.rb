require 'rails_helper'

module Helpers
  module Request
    module Api
      def jsonParsed
        @json ||= JSON.parse(response.body, symbolize_names: true)
      end
    end
  end
end
