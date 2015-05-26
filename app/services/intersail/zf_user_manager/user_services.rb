module Intersail
  module ZfUserManager
    module UserServices
      include Intersail::ZfUserManager::ZclientServices
      include Intersail::ZfUserManager::SearchServices

      SEARCH_PARAMETERS = [:full_text_search, :unit_select, :role_select]

      def user_index_function
        @unit_select = unit_select
        @role_select = role_select
        @users = zum.user_list(user_search_params(@search_params))
      end

      def user_search_params(params)
        parameters = {}
        unless params[:full_text_search].blank?
          parameters['full_text_search'] = params[:full_text_search]
        end

        unless params[:unit_select].blank?
          parameters['unit_id'] = params[:unit_select]
        end

        unless params[:role_select].blank?
          parameters['role_id'] = params[:role_select]
        end

        parameters
      end

      def set_user_search_params_function
        search_params(params, SEARCH_PARAMETERS)
      end

      def user_new_function
        @unit_select = unit_select
        @role_select = role_select
        @user = new_user
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

      def user_create_function
        user = set_user_attributes

        begin
          user = zum.user_create(user)
          @user = user
          clean_search_params
        rescue
          @user = user
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

        user.resource.urrs = []
        unless params[:urrs].blank?
          params[:urrs].each do |urr|
            user.resource.urrs.push(Intersail::ZfClient::ZUrr.new(id: urr[:urr_id], unit_id: urr[:unit_id], role_id: urr[:role_id], resource_id: user.resource.id, _destroy: urr[:_destroy].to_i))
          end
        end

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