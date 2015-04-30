module Intersail
  module ZfUserManager
    class ApplicationController < ActionController::Base
      before_action :set_current_section

      layout 'application'

      def set_current_section
        @zum_section = controller_name.downcase
      end
    end
  end
end
