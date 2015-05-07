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

      def process_instance_select
        zum.process_instance_list.map {|role| [role.name.humanize, role.id]}
      end

    end
  end
end