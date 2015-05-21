module Intersail
  module ZfUserManager
    module Concerns
      module TabPersistable
        extend ActiveSupport::Concern

        included do
          before_action :set_target_tab, only: [:update]
        end

        def set_target_tab
          @target_tab = params[:current_tab] if params[:current_tab]
        end
      end
    end
  end
end