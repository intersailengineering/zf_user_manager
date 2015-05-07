module Intersail
  module ZfUserManager
    module RoleServices
      include Intersail::ZfUserManager::ZclientServices
      include Intersail::ZfUserManager::SearchServices

      SEARCH_PARAMETERS = [:full_text_search]

      def role_index_function
        @roles = zum.role_list(@search_params)
      end

      def set_role_search_params_function
        search_params(params, SEARCH_PARAMETERS)
      end

      def role_show_function
        role_index_function
      end

      def role_update_function
        role = set_role_attributes(@role)
        role = zum.role_update(role.id, role)

        @role = role if role

        role_index_function
      end

      def role_destroy_function
        zum.role_delete(@role.id)

        @role = nil

        role_index_function
      end

      def role_create_function
        role = set_role_attributes

        begin
          role = zum.role_create(role)
          @role = role
          clean_search_params
        rescue
          set_error_message('Campi mancanti o non compilati correttamente')
        end

        role_index_function
      end

      def set_role_attributes(base_role = nil)
        role = base_role || new_role

        role.name = params[:name]
        role.description = params[:description]
        role.parent = params[:parent]
        role
      end

      def new_role
        Intersail::ZfClient::ZRole.new
      end

      def set_role_function(id)
        @role = zum.role_read(id)
      end

    end
  end
end