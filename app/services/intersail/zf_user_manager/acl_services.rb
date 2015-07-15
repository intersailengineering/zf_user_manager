module Intersail
  module ZfUserManager
    module AclServices
      include Intersail::ZfUserManager::ZclientServices
      include Intersail::ZfUserManager::SearchServices

      SEARCH_PARAMETERS = [:process_def_select, :unit_select, :role_select]
      ACL_ACTIONS = %w(a k c x r w t d !)
      INHERIT_SELECT = [
          ['Padre L3', 3],
          ['Padre L2', 2],
          ['Padre L1', 1],
          ['Figli L1', -1],
          ['Figli L2', -2],
          ['Figli L3', -3]
      ]

      def acl_index_function
        set_unit_data
        set_role_data
        set_resource_data
        set_process_def_data
        set_activity_def_data
        @inherit_select = INHERIT_SELECT

        @acls = zum.acl_list(acl_search_params(@search_params))
      end

      def acl_search_params(params)
        parameters = {}
        unless params[:process_def_select].blank?
          parameters['process_def_id'] = params[:process_def_select]
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
        set_unit_data
        set_role_data
        set_resource_data
        set_process_def_data
        set_activity_def_data
        @inherit_select = INHERIT_SELECT

        @acl = new_acl
        set_acl_actions_data
      end

      def acl_show_function
        acl_index_function
        set_acl_actions_data
      end

      def acl_update_function
        acl = set_acl_attributes(@acl)
        acl = zum.acl_update(acl.id, acl)
        @acl = acl if acl
        acl_index_function
        set_acl_actions_data
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
        set_acl_actions_data
      end

      def set_acl_attributes(base_acl = nil)
        acl = base_acl || new_acl

        acl.process_def_id = params[:process_def_id]
        acl.activity_def_id = params[:activity_def_id].blank? ? 0 : params[:activity_def_id]
        acl.unit_id = params[:unit_id].blank? ? 0 : params[:unit_id]
        acl.role_id = params[:role_id].blank? ? 0 : params[:role_id]
        acl.resource_id = params[:resource_id].blank? ? 0 : params[:resource_id]
        acl.priority = params[:priority].blank? ? 0 : params[:priority]
        acl.inherit_unit = params[:inherit_unit].blank? ? 0 : params[:inherit_unit]
        acl.inherit_role = params[:inherit_role].blank? ? 0 : params[:inherit_role]
        acl.mandatory = params[:mandatory] == '1' ? true : false
        acl.enabled = params[:enabled] == '1' ? true : false
        acl.permission_str = get_permission_string
        acl
      end

      def set_dictionaries
        @process_def_dictionary = process_def_dictionary
        @activity_def_dictionary = activity_def_dictionary
      end

      def set_unit_data
        list = zum.unit_list

        @unit_dictionary = {}
        list.each do |u|
          @unit_dictionary[u.id] = u.name.humanize
        end

        @unit_select = unit_select(list)
      end

      def set_role_data
        list = zum.role_list

        @role_dictionary = {}
        list.each do |r|
          @role_dictionary[r.id] = r.name.humanize
        end

        @role_select = role_select(list)
      end

      def set_resource_data
        list = zum.resource_list

        @resource_dictionary = {}
        list.each do |r|
          @resource_dictionary[r.id] = "#{r.first_name.humanize} #{r.last_name.humanize}"
        end

        @resource_select = resource_select(list)
      end

      def set_process_def_data
        list = zum.process_def_list

        @process_def_dictionary = {}
        list.each do |p|
          @process_def_dictionary[p.id] = p.name.humanize
        end

        @process_def_select = process_def_select(list)
      end

      def set_activity_def_data
        list = zum.activity_def_list

        @activity_def_dictionary = {}
        list.each do |a|
          @activity_def_dictionary[a.id] = a.name.humanize
        end

        @activity_def_select = activity_def_select(list)
      end

      def set_acl_actions_data
        @acl_actions = {}
        ACL_ACTIONS.each do |action|
          @acl_actions[action.to_sym] = false
        end

        return if @acl.permission_str.blank?
        @acl.permission_str.each_char do |c|
          @acl_actions[c.to_sym] = true
        end
      end

      def get_permission_string
        permission_string = ''
        ACL_ACTIONS.each do |action|
          permission_string += action if params["acl_action_#{action}"] == '1'
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