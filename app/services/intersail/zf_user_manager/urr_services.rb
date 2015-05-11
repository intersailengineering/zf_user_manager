module Intersail
  module ZfUserManager
    module UrrServices
      include Intersail::ZfUserManager::ZclientServices

      def urr_new_function
        @urr = Intersail::ZfClient::ZUrr.new(id: nil,
                                             unit: Intersail::ZfClient::ZUnit.new(id: params[:unit], name: params[:unit_name]),
                                             role: Intersail::ZfClient::ZRole.new(id: params[:role], name: params[:role_name]),
                                             resource: Intersail::ZfClient::ZResource.new(id: params[:resource]))
      end

    end
  end
end