module Intersail
  module ZfUserManager
    module SearchServices

      def search_params(params, search_params = [])
        @search_params = {}
        search_params.each do |search_param|
          @search_params[search_param] = params[search_param] if params[search_param]
        end
      end

      def clean_search_params
        @search_params = {}
      end

    end
  end
end