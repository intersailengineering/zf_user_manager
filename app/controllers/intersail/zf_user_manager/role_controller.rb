module Intersail
  module ZfUserManager
    class RoleController < ApplicationController
      include Intersail::ZfUserManager::Concerns::Messageable
      include Intersail::ZfUserManager::RoleServices

      before_action :set_role, only: [:show, :create, :update, :destroy]
      before_action :set_section
      before_action :set_role_search_params, only: [:index, :show, :create, :update, :destroy]

      def index
        role_index_function
      end

      def show
        role_show_function
        render 'index'
      end

      def create
        role_create_function
        render 'index'
      end

      def update
        role_update_function
        render 'index'
      end

      def destroy
        role_destroy_function
        render 'index'
      end

      private

      def set_role
        set_role_function(params[:id])
      end

      def set_section
        @section = :role
      end

      def set_role_search_params
        set_role_search_params_function
      end
    end
  end
end