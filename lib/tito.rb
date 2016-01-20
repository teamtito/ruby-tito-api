require 'json_api_client'
require "tito/version"
require "tito/base"
require "tito/oauth2_middleware"
require "tito/eventable"

require "tito/account"
require "tito/event"
require "tito/webhook_endpoint"

module Tito
  cattr_accessor :api_key
end

Tito::Base.connection do |connection|
  connection.use Tito::OAuth2Middleware, lambda { |env| Tito.api_key }
end