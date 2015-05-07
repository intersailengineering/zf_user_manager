module Intersail
  module ZfUserManager
    class UrrController < ApplicationController
      include Intersail::ZfUserManager::Concerns::Messageable
      include Intersail::ZfUserManager::UrrServices

      def new
        urr_new_function
      end

      def update
        urr_update_function
      end

      def destroy
        urr_destroy_function
      end

      private



    end
  end
end
