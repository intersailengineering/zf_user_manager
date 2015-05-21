module Intersail
  module ZfUserManager
    module AclServices
      include Intersail::ZfUserManager::ZclientServices
      include Intersail::ZfUserManager::SearchServices

      SEARCH_PARAMETERS = [:process_def_select, :unit_select, :role_select]
      ACL_ACTIONS = %w(a k c x r w t d !)

      def acl_index_function
        @unit_select = unit_select
        @role_select = role_select
        @process_def_select = process_def_select

        @acls = zum.acl_list(acl_search_params(@search_params))
      end

      def acl_search_params(params)
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

      def set_acl_search_params_function
        search_params(params, SEARCH_PARAMETERS)
      end

      def acl_new_function
        @unit_select = unit_select
        @role_select = role_select
        @acl = new_acl
      end

      def acl_show_function
        acl_index_function
      end

      def acl_update_function
        acl = set_acl_attributes(@acl)
        acl = zum.acl_update(acl.id, acl)

        @acl = acl if acl

        acl_index_function
      end

      def acl_destroy_function
        zum.acl_delete(@acl.id)

        @acl = nil

        acl_index_function
      end

      def acl_create_function
        acl = set_acl_attributes

        begin
          acl = zum.acl_create(acl)
          @acl = acl
          clean_search_params
        rescue
          set_error_message('Campi mancanti o non compilati correttamente')
        end

        acl_index_function
      end

      def set_acl_attributes(base_acl = nil)
        acl = base_acl || new_acl

        acl.process_id = params[:process_id]
        acl.activity_id params[:activity_id]
        acl.unit_id = params[:unit_id]
        acl.role_id = params[:role_id]
        acl.resource_id = params[:resource_id]
        acl.priority = params[:priority]
        acl.inherit_unit = params[:inherit_unit]
        acl.inherit_role = params[:inherit_role]
        acl.mandatory = params[:mandatory] == 'true' ? true : false
        acl.enabled = params[:enabled] == 'true' ? true : false
        acl.permission = get_permission_string
        acl
      end

      def get_permission_string
        permission_string = ''
        ACL_ACTIONS.each do |action|
          permission_string += action if params["action_#{action}"] == 'true'
        end
        permission_string
      end

      def new_acl
        Intersail::ZfClient::ZAcl.new
      end

      def set_acl_function(id)
        @acl = zum.acl_read(id)
      end

    end
  end
end