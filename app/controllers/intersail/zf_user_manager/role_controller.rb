module Intersail
  module ZfUserManager
    class RoleController < ApplicationController
      include Intersail::ZfUserManager::Concerns::Messageable
      include Intersail::ZfUserManager::RoleServices

      before_action :set_role, only: [:show, :update, :destroy]
      before_action :set_section
      before_action :set_role_search_params, only: [:new, :index, :show, :create, :update, :destroy]

      def index
        role_index_function

        respond_to do |format|
          format.html { render 'intersail/zf_user_manager/shared/index' }
        end
      end

      def new
        role_new_function

        respond_to do |format|
          format.js { render 'intersail/zf_user_manager/shared/new' }
        end
      end

      def show
        role_show_function

        respond_to do |format|
          format.js { render 'intersail/zf_user_manager/shared/show' }
        end
      end

      def create
        role_create_function

        respond_to do |format|
          format.js { render 'intersail/zf_user_manager/shared/create' }
        end
      end

      def update
        role_update_function

        respond_to do |format|
          format.js { render 'intersail/zf_user_manager/shared/update' }
        end
      end

      def destroy

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