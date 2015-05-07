module Intersail
  module ZfUserManager
    class UrrController < ApplicationController
      include Intersail::ZfUserManager::Concerns::Messageable
      include Intersail::ZfUserManager::UrrServices

      def new
        urr_new_function
      end

      def update_all
        urr_update_all_function
      end

      def destroy
        urr_destroy_function
      end

      private



    end
  end
end
