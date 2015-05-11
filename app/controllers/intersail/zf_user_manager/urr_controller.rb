module Intersail
  module ZfUserManager
    class UrrController < ApplicationController
      include Intersail::ZfUserManager::Concerns::Messageable
      include Intersail::ZfUserManager::UrrServices

      def new
        urr_new_function
      end

    end
  end
end
