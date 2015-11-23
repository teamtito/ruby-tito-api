require 'json_api_client'
require "tito/version"
require "tito/json_request"
require "tito/base"
require "tito/event"

module Tito
  class Api
    def self.set_token token
      Tito::Base.connection do |connection|
        connection.delete JsonApiClient::Middleware::JsonRequest
        connection.use Tito::JsonRequest
        connection.use FaradayMiddleware::OAuth2, token
      end
    end
  end
end