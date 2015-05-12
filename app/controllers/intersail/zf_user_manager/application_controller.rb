module Intersail
  module ZfUserManager
    class ApplicationController < ActionController::Base
      layout 'application'

      before_action :authenticate_user!
    end
  end
end
