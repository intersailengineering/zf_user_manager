module Intersail
  module ZfUserManager
    module RoleServices
      include Intersail::ZfUserManager::ZclientServices
      include Intersail::ZfUserManager::SearchServices

      SEARCH_PARAMETERS = [:full_text_search]

      def role_index_function
        @resource_select = resource_select
        @unit_select = unit_select
        @roles = zum.role_list(role_search_params(@search_params))
      end

      def role_search_params(params)
        parameters = {}
        unless params[:full_text_search].blank?
          parameters['full_text_search'] = params[:full_text_search]
        end

        parameters
      end

      def set_role_search_params_function
        search_params(params, SEARCH_PARAMETERS)
      end

      def role_new_function
        @resource_select = resource_select
        @unit_select = unit_select
        @role = new_role

        role_urrs
      end

      def role_show_function
        role_index_function

        role_urrs
      end

      def role_update_function
        role = set_role_attributes(@role)
        role = zum.role_update(role.id, role)
        role_urrs_update

        @role = role if role

        role_index_function
        role_urrs
      end

      def role_urrs_update
        return nil if params[:urrs].blank?

        params[:urrs].each do |urr|
          if urr[:urr_id] == '0'
            u = Intersail::ZfClient::ZUrr.new(id: nil, unit_id: urr[:unit_id], role_id: @role.id, resource_id: urr[:resource_id])
            zum.urr_create(u)
          elsif urr[:_edited] == '1'
            u = Intersail::ZfClient::ZUrr.new(id: urr[:urr_id], unit_id: urr[:unit_id], role_id: @role.id, resource_id: urr[:resource_id], _destroy: urr[:_destroy].to_i)
            zum.urr_update(u.id, u)
          end
        end
        params.delete(:urrs)
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
        role_urrs
      end

      def role_urrs
        @role_urrs = zum.urr_list({role_id: @role.id})

        resources_ids = []
        units_ids = []
        @role_urrs.each do |urr|
          resources_ids.push(urr.resource_id) unless resources_ids.include?(urr.resource_id)
          units_ids.push(urr.unit_id) unless units_ids.include?(urr.unit_id)
        end

        resources = resources_ids.blank? ? zum.resource_list : zum.resource_list(id: resources_ids.join(','))
        @role_urr_resources = {}
        resources.each do |r|
          @role_urr_resources[r.id] = "#{r.first_name} #{r.last_name}"
        end

        units = units_ids.blank? ? zum.unit_list : zum.unit_list(id: units_ids.join(','))
        @role_urr_units = {}
        units.each do |u|
          @role_urr_units[u.id] = u.name
        end
      end

      def set_role_attributes(base_role = nil)
        role = base_role || new_role

        role.name = params[:name]
        role.description = params[:description]
        role.parent_id = params[:parent_id].blank? ? 0 : params[:parent_id]
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