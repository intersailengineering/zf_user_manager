module Intersail
  module ZfUserManager
    class AclController < Intersail::ZfUserManager::ApplicationController
      include Intersail::ZfUserManager::Concerns::Messageable
      include Intersail::ZfUserManager::AclServices

      before_action :set_acl, only: [:show, :update, :destroy]
      before_action :set_section
      before_action :set_acl_search_params, only: [:new, :index, :show, :create, :update, :destroy]

      def index
        acl_index_function

        respond_to do |format|
          format.html { render 'intersail/zf_user_manager/shared/index' }
        end
      end

      def new
        acl_new_function

        respond_to do |format|
          format.js { render 'intersail/zf_user_manager/shared/new' }
        end
      end

      def show
        acl_show_function

        respond_to do |format|
          format.js { render 'intersail/zf_user_manager/shared/show' }
        end
      end

      def create
        acl_create_function

        respond_to do |format|
          format.js { render 'intersail/zf_user_manager/shared/create' }
        end
      end

      def update
        acl_update_function

        respond_to do |format|
          format.js { render 'intersail/zf_user_manager/shared/update' }
        end
      end

      def destroy

      end

      private

      def set_acl
        set_acl_function(params[:id])
      end

      def set_section
        @section = :acl
      end

      def set_acl_search_params
        set_acl_search_params_function
      end
    end
  end
end