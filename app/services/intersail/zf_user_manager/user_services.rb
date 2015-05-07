module Intersail
  module ZfUserManager
    module UserServices
      include Intersail::ZfUserManager::ZclientServices
      include Intersail::ZfUserManager::SearchServices

      SEARCH_PARAMETERS = [:full_text_search, :unit_select, :role_select]

      def user_index_function
        @unit_select = unit_select
        @role_select = role_select
        @users = zum.user_list(@search_params)
      end

      def set_user_search_params_function
        search_params(params, SEARCH_PARAMETERS)
      end

      def user_show_function
        user_index_function
      end

      def user_update_function
        user = set_user_attributes(@user)
        user = zum.user_update(user.id, user)

        @user = user if user

        user_index_function
      end

      def user_destroy_function
        zum.user_delete(@user.id)

        @user = nil

        user_index_function
      end

      def user_create_function
        user = set_user_attributes

        begin
          user = zum.user_create(user)
          @user = user
          clean_search_params
        rescue
          set_error_message('Campi mancanti o non compilati correttamente')
        end

        user_index_function
      end

      def set_user_attributes(base_user = nil)
        user = base_user || new_user

        user.username = params[:username]
        user.active = params[:active] == 'true' ? true : false
        user.resource.first_name = params[:first_name]
        user.resource.last_name = params[:last_name]
        user.resource.mail = params[:mail]
        user
      end

      def new_user
        Intersail::ZfClient::ZUser.new(resource: Intersail::ZfClient::ZResource.new)
      end

      def set_user_function(id)
        @user = zum.user_read(id)
      end

    end
  end
end