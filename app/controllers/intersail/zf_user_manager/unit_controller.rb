module Intersail
  module ZfUserManager
    class UnitController < ApplicationController
      include Intersail::ZfUserManager::Concerns::Messageable
      include Intersail::ZfUserManager::Concerns::TabPersistable
      include Intersail::ZfUserManager::UnitServices

      before_action :set_unit, only: [:show, :create, :update, :destroy]
      before_action :set_section
      before_action :set_unit_search_params, only: [:index, :show, :create, :update, :destroy]

      def index
        unit_index_function

        respond_to do |format|
          format.html { render 'intersail/zf_user_manager/shared/index' }
        end
      end

      def new
        unit_new_function

        respond_to do |format|
          format.js { render 'intersail/zf_user_manager/shared/new' }
        end
      end

      def show
        unit_show_function

        respond_to do |format|
          format.js { render 'intersail/zf_user_manager/shared/show' }
        end
      end

      def create
        unit_create_function

        respond_to do |format|
          format.js { render 'intersail/zf_user_manager/shared/create' }
        end
      end

      def update
        unit_update_function

        respond_to do |format|
          format.js { render 'intersail/zf_user_manager/shared/update' }
        end
      end

      def destroy

      end

      private

      def set_unit
        set_unit_function(params[:id])
      end

      def set_section
        @section = :unit
      end

      def set_unit_search_params
        set_unit_search_params_function
      end
    end
  end
end
