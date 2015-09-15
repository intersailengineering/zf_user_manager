module Intersail
  module ZfUserManager
    class ApplicationController < ActionController::Base
      # this is needed in order to work with rails 4.1
      layout proc{|c| c.request.xhr? ? false : "application_zum" }

      mattr_accessor :logged_user

      before_action :authenticate_user!
      before_action :set_logged_user!

      private
      def set_logged_user!
        self.logged_user = current_user
      end
    end
  end
end
