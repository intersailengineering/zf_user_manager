module Intersail
  module ZfUserManager
    module ZclientServices

      def zum
        @zum ||= Intersail::ZfClient::Client::ZClient.new(ApplicationController.logged_user.session_id)
      end

      def unit_select(list = nil)
        (list || zum.unit_list).map {|unit| [unit.name.humanize, unit.id]}
      end

      def role_select(list = nil)
        (list || zum.role_list).map {|role| [role.name.humanize, role.id]}
      end

      def resource_select(list = nil)
        (list || zum.resource_list).map {|resource| ["#{resource.first_name.humanize} #{resource.last_name.humanize}", resource.id]}
      end

      def process_def_select(list = nil)
        (list || zum.process_def_list).map {|process_def| [process_def.name.humanize, process_def.id]}
      end

      def activity_def_select(list = nil)
        (list || zum.activity_def_list).map {|activity_def| [activity_def.name.humanize, activity_def.id]}
      end

    end
  end
end