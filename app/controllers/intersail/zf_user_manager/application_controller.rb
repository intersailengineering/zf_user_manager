module Intersail
  module ZfUserManager
    class ApplicationController < ActionController::Base
      layout 'application_zum'

      before_action :authenticate_user!
    end
  end
end
