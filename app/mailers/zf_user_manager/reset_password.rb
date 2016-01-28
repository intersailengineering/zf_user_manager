module ZfUserManager
  class ResetPassword < ApplicationMailer
    def reset_password(data, app_name, username, password, login_url)
      @app_name = app_name
      @username = username
      @password = password
      @login_url = login_url
      mail data
    end
  end
end
