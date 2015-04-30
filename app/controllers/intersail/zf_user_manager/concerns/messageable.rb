module Intersail
  module ZfUserManager
    module Concerns
      module Messageable
        extend ActiveSupport::Concern

        included do
          before_action :restore_messages_from_session

          def restore_messages_from_session
            restore_from_session
          end
        end

        RENDER_MESSAGES_TAG = 'render_messages'
        TYPE = :type
        FORMAT = :format
        MESSAGES = :messages
        ERROR = :error
        SUCCESS = :success
        STRING = :string
        ARRAY = :array

        def store_in_session(object)
          session[:render_messages_options] = object
        end

        def restore_from_session
          if session[:render_messages_options]
            @render_messages_options = session[:render_messages_options]
            session[:render_messages_options] = nil
          end
        end

        def set(type, format, messages, store)
          options = {}
          options[TYPE] = type
          options[FORMAT] = format
          options[MESSAGES] = messages
          @render_messages_options = options
          store_in_session(@render_messages_options) if store
          @render_messages_options
        end

        def set_success_message(message, store=false)
          set(SUCCESS, STRING, message, store)
        end

        def set_error_message(message, store=false)
          set(ERROR, STRING, message, store)
        end

        def set_error_messages(array, store=false)
          set(ERROR, ARRAY, array, store)
        end
      end
    end
  end
end