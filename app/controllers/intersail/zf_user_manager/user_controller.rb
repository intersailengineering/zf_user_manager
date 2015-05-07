module Intersail
  module ZfUserManager
    class UserController < ApplicationController
      include Intersail::ZfUserManager::Concerns::Messageable
      include Intersail::ZfUserManager::UserServices

      before_action :set_user, only: [:show, :create, :update, :destroy]
      before_action :set_section
      before_action :set_user_search_params, only: [:index, :show, :create, :update, :destroy]

      def index
        user_index_function
      end

      def show
        user_show_function
        render 'index'
      end

      def create
        user_create_function
        render 'index'
      end

      def update
        puts '>>>>>>>>>>>>>>> ' + params.inspect

        user_update_function
        render 'index'
      end

      def destroy
        user_destroy_function
        render 'index'
      end

      private

      def set_user
        set_user_function(params[:id])
      end

      def set_section
        @section = :user
      end

      def set_user_search_params
        set_user_search_params_function
      end
    end
  end
end
