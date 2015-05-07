module Intersail
  module ZfUserManager
    class AclController < ApplicationController
      include Intersail::ZfUserManager::Concerns::Messageable
      include Intersail::ZfUserManager::AclServices

      before_action :set_acl, only: [:show, :create, :update, :destroy]
      before_action :set_section
      before_action :set_acl_search_params, only: [:index, :show, :create, :update, :destroy]

      def index
        acl_index_function
      end

      def show
        acl_show_function
        render 'index'
      end

      def create
        acl_create_function
        render 'index'
      end

      def update
        acl_update_function
        render 'index'
      end

      def destroy
        acl_destroy_function
        render 'index'
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