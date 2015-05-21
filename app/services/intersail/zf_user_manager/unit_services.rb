module Intersail
  module ZfUserManager
    module UnitServices
      include Intersail::ZfUserManager::ZclientServices
      include Intersail::ZfUserManager::SearchServices

      SEARCH_PARAMETERS = [:full_text_search]

      def unit_index_function
        @resource_select = resource_select
        @role_select = role_select
        @units = zum.unit_list(unit_search_params(@search_params))
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
      end

      def unit_show_function
        unit_index_function
      end

      def unit_update_function
        unit = set_unit_attributes(@unit)
        unit = zum.unit_update(unit.id, unit)

        @unit = unit if unit

        unit_index_function
      end

      def unit_destroy_function
        zum.unit_delete(@unit.id)

        @unit = nil

        unit_index_function
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
      end

      def set_unit_attributes(base_unit = nil)
        unit = base_unit || new_unit

        unit.name = params[:name]
        unit.description = params[:description]
        unit.parent = params[:parent]
        unit
      end

      def new_unit
        Intersail::ZfClient::ZUnit.new
      end

      def set_unit_function(id)
        @unit = zum.unit_read(id)
      end

    end
  end
end