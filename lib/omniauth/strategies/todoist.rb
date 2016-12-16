require 'omniauth-oauth2'
require 'multi_json'


module OmniAuth
  module Strategies
    class Todoist < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPE = 'data:read'

      # Give your strategy a name.
      option :name, "todoist"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {
        :site => "https://todoist.com",
        :authorize_url => "/oauth/authorize",
        :token_url => "/oauth/access_token"
      }

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid{ raw_info['id'] }

      info do
        { :email => raw_info["email"] }
      end

      def request_phase
        super
      end

      def callback_phase
          super
      end

      # Bugfix for regression introduced after omniauth-oauth2 v1.3.1
      # details: https://github.com/intridea/omniauth-oauth2/issues/81
      def callback_url
        options[:callback_url] || full_host + script_name + callback_path
      end

      def raw_info
        unless @raw_info
          user_info = access_token.post("/API/v7/sync", { 
            body: { 
              token: access_token.token, 
              sync_token: "*", 
              resource_types: '["user"]' }, 
            headers: {
              "Content-Type"=>"application/x-www-form-urlencoded" }
          }).parsed
          if user_info["user"]  
            @raw_info = user_info["user"]
          else
            @raw_info = {}
          end
        end
        @raw_info
      end
    end
  end
end


