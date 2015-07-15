module Intersail
  module ZfUserManager
    module UnitServices
      extend ActiveSupport::Concern
      include Intersail::ZfUserManager::ZclientServices
      include Intersail::ZfUserManager::SearchServices

      SEARCH_PARAMETERS = [:full_text_search]

      included do
        helper_method :fetch_unit_options
      end

      def unit_index_function
        @resource_select = resource_select
        @role_select = role_select
        @units = zum.unit_list(unit_search_params(@search_params))

        update_unit_parents
      end

      def unit_search_params(params)
        parameters = {}
        unless params[:full_text_search].blank?
          parameters['full_text_search'] = params[:full_text_search]
        end

        parameters
      end

      def set_unit_search_params_function
        search_params(params, SEARCH_PARAMETERS)
      end

      def unit_new_function
        @resource_select = resource_select
        @role_select = role_select
        @unit = new_unit

        unit_urrs
      end

      def unit_show_function
        unit_index_function

        unit_urrs
      end

      def unit_update_function
        unit = set_unit_attributes(@unit)
        unit = zum.unit_update(unit.id, unit)
        unit_urrs_update

        @unit = unit if unit

        unit_index_function
        unit_urrs
      end

      def unit_urrs_update
        return nil if params[:urrs].blank?

        params[:urrs].each do |urr|
          if urr[:urr_id] == '0'
            u = Intersail::ZfClient::ZUrr.new(id: nil, unit_id: @unit.id, role_id: urr[:role_id], resource_id: urr[:resource_id])
            zum.urr_create(u)
          elsif urr[:_edited] == '1'
            u = Intersail::ZfClient::ZUrr.new(id: urr[:urr_id], unit_id: @unit.id, role_id: urr[:role_id], resource_id: urr[:resource_id], _destroy: urr[:_destroy].to_i)
            zum.urr_update(u.id, u)
          end
        end
        params.delete(:urrs)
      end

      def unit_create_function
        unit = set_unit_attributes

        begin
          unit = zum.unit_create(unit)
          @unit = unit
          clean_search_params
        rescue
          set_error_message('Campi mancanti o non compilati correttamente')
        end

        unit_index_function
        unit_urrs
      end

      def unit_urrs
        @unit_urrs = zum.urr_list({unit_id: @unit.id})

        resources_ids = []
        roles_ids = []
        @unit_urrs.each do |urr|
          resources_ids.push(urr.resource_id) unless resources_ids.include?(urr.resource_id)
          roles_ids.push(urr.role_id) unless roles_ids.include?(urr.role_id)
        end

        resources = resources_ids.blank? ? zum.resource_list : zum.resource_list(id: resources_ids.join(','))
        @unit_urr_resources = {}
        resources.each do |r|
          @unit_urr_resources[r.id] = "#{r.first_name} #{r.last_name}"
        end

        roles = roles_ids.blank? ? zum.role_list : zum.role_list(id: roles_ids.join(','))
        @unit_urr_roles = {}
        roles.each do |r|
          @unit_urr_roles[r.id] = r.name
        end
      end

      def set_unit_attributes(base_unit = nil)
        unit = base_unit || new_unit

        unit.name = params[:name]
        unit.description = params[:description]
        unit.parent_id = params.fetch(:unit, {}).fetch(:parent_id,0).to_i
        # unit.parent_id = params[:parent_id].blank? ? 0 : params[:parent_id]
        unit
      end

      def new_unit
        Intersail::ZfClient::ZUnit.new
      end

      def set_unit_function(id)
        @unit = zum.unit_read(id)
      end

      private
      # create the array that contain all the unit options for the select
      def fetch_unit_options
        zum.unit_list.inject([["-",0]]) {|units,unit| units << [unit.name,unit.id]}
      end
      # set the parent object of the unit if has any parent_id setted
      # works using the local units found from the client
      def update_unit_parents
        @units.map {|unit| update_unit_parent(unit) }
      end

      def update_unit_parent(unit)
        return unless unit.parent_id != 0
        unit.parent = @units.find {|u| u.id == unit.parent_id}
      end
    end
  end
end