module Intersail
  module ZfUserManager
    class UnitController < ApplicationController
      include Intersail::ZfUserManager::Concerns::Messageable
      include Intersail::ZfUserManager::UnitServices

      before_action :set_unit, only: [:show, :create, :update, :destroy]
      before_action :set_section
      before_action :set_unit_search_params, only: [:index, :show, :create, :update, :destroy]

      def index
        unit_index_function
      end

      def show
        unit_show_function
        render 'index'
      end

      def create
        unit_create_function
        render 'index'
      end

      def update
        unit_update_function
        render 'index'
      end

      def destroy
        unit_destroy_function
        render 'index'
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
