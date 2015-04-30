module Intersail
  module ZfUserManager
    module UserServices
      include Intersail::ZfUserManager::SearchServices

      SEARCH_PARAMETERS = [:full_text_search, :unit_select, :role_select]

      def zum
        Intersail::ZfClient::Client::ZClient.new
      end

      def index_function
        @unit_select = user_units
        @role_select = user_roles

        @users = zum.all_users(@search_params)
      end

      def set_search_params_function
        search_params(params, SEARCH_PARAMETERS)
      end

      def show_function
        index_function
      end

      def update_function
        user = set_user_attributes(@user)
        user = zum.update_user(user)

        @user = user if user

        index_function
      end

      def destroy_function
        zum.delete_user(@user.id)

        @user = nil

        index_function
      end

      def add_profile_function
        z = zum
        urr = z.create_urr({user_id: @user.id, unit_id: params[:unit], role_id: params[:role]})
        user = @user
        user.urrs.push(urr)
        user = z.update_user(user)

        @user = user if user

        index_function
      end

      def destroy_profile_function
        z = zum
        z.delete_urr(params[:profile_id])

        @user = z.get_user(@user.id)

        index_function
      end

      def create_function
        user = set_user_attributes

        begin
          user = zum.create_user(user)
          @user = user
          clean_search_params
        rescue
          set_error_message('Campi mancanti o non compilati correttamente')
        end

        index_function
      end

      def set_user_attributes(base_user = nil)
        user = base_user || new_user

        user.username = params[:username]
        set_user_password(user)
        user.active = params[:active] == 'true' ? true : false
        user.profile.first_name = params[:first_name]
        user.profile.last_name = params[:last_name]
        user.profile.mail = params[:mail]
        user
      end

      def set_user_password(user)
        unless params[:password].blank? || params[:password_confirmation].blank?
          if params[:password] == params[:password_confirmation]
            user.password = params[:password]
          end
        end
      end

      def new_user
        Intersail::ZfClient::ZUser.new(profile: Intersail::ZfClient::ZUserProfile.new)
      end

      def set_user_function(id)
        @user = zum.get_user(id)
      end

      def user_units
        #zum.all_units.map {|unit| [unit.name.humanize, unit.id]}
        [['Unità 1', 1], ['Unità 2', 2], ['Unità 3', 3]]
      end

      def user_roles
        #zum.all_roles.map {|role| [role.name.humanize, role.id]}
        [['Ruolo 1', 1], ['Ruolo 2', 2], ['Ruolo 3', 3]]
      end

    end
  end
end