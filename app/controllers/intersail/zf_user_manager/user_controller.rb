module Intersail
  module ZfUserManager
    # NOTE: Why are using the full name space because otherwise it will load the host application ApplicationController
    class UserController < Intersail::ZfUserManager::ApplicationController
      include Intersail::ZfUserManager::Concerns::Messageable
      include Intersail::ZfUserManager::UserServices

      before_action :set_user, only: [:show, :update, :destroy, :reset_password]
      before_action :set_section
      before_action :set_user_search_params, only: [:new, :index, :show, :create, :update, :destroy, :reset_password]

      def index
        user_index_function

        respond_to do |format|
          format.html { render 'intersail/zf_user_manager/shared/index' }
        end
      end

      def new
        user_new_function

        respond_to do |format|
          format.js { render 'intersail/zf_user_manager/shared/new' }
        end
      end

      def show
        user_show_function

        respond_to do |format|
          format.js { render 'intersail/zf_user_manager/shared/show' }
        end
      end

      def create
        user_create_function

        respond_to do |format|
          format.js { render 'intersail/zf_user_manager/shared/update' }
        end
      end

      def update
        user_update_function

        respond_to do |format|
          format.js { render 'intersail/zf_user_manager/shared/update' }
        end
      end

      def destroy

      end

      def reset_password
        user_show_function

        service = GeneratePasswordService.new(params[:id],zum, APP_CONFIG['app_name'], APP_CONFIG['login_url'])
        begin
          res = service.call
          if (res.code == 200)
            set_success_message("Invio password di reset effettuato con successo a #{res["email"]}.")
          else
            set_error_message("C'è stato un errore nel reset della password utente.")
            Rails.logger.error("Reset password error: #{res.body}")
          end
        rescue StandardError => e
          set_error_message("C'è stato un errore nel reset della password utente.")
          Rails.logger.error("Reset password error: #{e.message}")
        rescue *SMTP_ERRORS => e
          set_error_message("C'è stato un errore nell'invio della password di reset all'utente. Per piacere riprovare più tardi.")
          Rails.logger.error("Reset password error: #{e.message}")
        end

        respond_to do |format|
          format.js { render 'intersail/zf_user_manager/shared/update' }
        end
      end

      private

      def set_user
        set_user_function(params[:id])
      end

      def set_section
        @section = :user
      end

      def set_user_search_params
        set_user_search_params_function
      end
    end
  end
end
