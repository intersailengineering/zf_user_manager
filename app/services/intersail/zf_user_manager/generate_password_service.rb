module Intersail
  module ZfUserManager
    class GeneratePasswordService

      attr_accessor :user_id
      attr_accessor :zf_client
      attr_accessor :app_name
      attr_accessor :login_url

      def initialize(user_id, zf_client, app_name, login_url)
        self.user_id = user_id
        self.zf_client = zf_client
        self.app_name = app_name
        self.login_url = login_url
      end

      def call
          res = self.zf_client.user.reset_password(self.user_id)
          if(res.code == 200)
            ::ZfUserManager::ResetPassword.reset_password({to: res["email"]}, self.app_name, res["username"], res["password"], self.login_url).deliver_later
          end
          res
      end
    end
  end
end
