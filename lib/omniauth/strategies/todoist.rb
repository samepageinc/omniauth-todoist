require 'omniauth-oauth2'
require 'multi_json'


module OmniAuth
  module Strategies
    class Todoist < OmniAuth::Strategies::OAuth2
      option :name, "todoist"

      option :client_options, {
        site:          "https://todoist.com",
        authorize_url: "/oauth/authorize",
        token_url:     "/oauth/access_token"
      }

      option :authorize_options, [:scope]

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid{ raw_info['id'].to_s }

      info do
        first_name, last_name = raw_info['full_name'].to_s.split(/\s+/, 2)

        prune!(
          name:       raw_info['full_name'],
          first_name: first_name,
          last_name:  last_name,
          email:      raw_info['email'],
          phone:      raw_info['mobile_number'],
          image:      raw_info['avatar_big'],
          time_zone:  raw_info['tz_info']['timezone']
        )
      end

      extra do
        prune!(raw_info: raw_info)
      end

      # Bugfix for regression introduced after omniauth-oauth2 v1.3.1
      # details: https://github.com/intridea/omniauth-oauth2/issues/81
      def callback_url
        options[:callback_url] || full_host + script_name + callback_path
      end

      def raw_info
        @raw_info ||= begin
          params = {
            headers: {
              "Content-Type" => "application/x-www-form-urlencoded"
            },
            body: {
              token: access_token.token,
              sync_token: "*",
              resource_types: '["user"]'
            }
          }
          access_token.post("/API/v7/sync", params).parsed.fetch('user', {})
        end
      end

    private
    
      def prune!(hash)
        hash.delete_if do |_, value|
          prune!(value) if value.is_a?(Hash)
          value.nil? || (value.respond_to?(:empty?) && value.empty?)
        end
      end
    end
  end
end
