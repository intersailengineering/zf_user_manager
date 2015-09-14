module Intersail
  module ZfUserManager
    class ApplicationController < ActionController::Base
      # this is needed in order to work with rails 4.1
      layout proc{|c| c.request.xhr? ? false : "application_zum" }

      before_action :authenticate_user!
    end
  end
end
