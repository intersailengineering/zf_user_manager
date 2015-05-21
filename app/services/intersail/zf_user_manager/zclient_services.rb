module Intersail
  module ZfUserManager
    module ZclientServices

      def zum
        @zum ||= Intersail::ZfClient::Client::ZClient.new("1")
      end

      def unit_select
        zum.unit_list.map {|unit| [unit.name.humanize, unit.id]}
      end

      def role_select
        zum.role_list.map {|role| [role.name.humanize, role.id]}
      end

      def resource_select
        zum.resource_list.map {|resource| ["#{resource.first_name.humanize} #{resource.last_name.humanize}", resource.id]}
      end

      def process_def_select
        zum.process_def_list.map {|process_def| [process_def.name.humanize, process_def.id]}
      end

    end
  end
end