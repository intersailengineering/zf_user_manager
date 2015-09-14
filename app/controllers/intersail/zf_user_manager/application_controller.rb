module Intersail
  module ZfUserManager
    class ApplicationController < ActionController::Base
      layout proc{|c| c.request.xhr? ? false : "application_zum" }

      before_action :authenticate_user!
    end
  end
end
