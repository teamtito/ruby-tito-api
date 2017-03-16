require 'http'
require "tito/version"
require "tito/base"
require "tito/eventable"
require "tito/request_proxy"
require "tito/response_array"

require "tito/account"
require "tito/answer"
require "tito/discount_code"
require "tito/event_settings"
require "tito/interested_user"
require "tito/question"
require "tito/registration"
require "tito/release"
require "tito/ticket"
require "tito/event"
require "tito/webhook_endpoint"

module Tito
  def self.api_key
    return @api_key if @api_key
    return ENV['TITO_API_KEY'] if ENV['TITO_API_KEY']
  end

  def self.api_key=(val)
    @api_key = val
  end
end

# Tito::Base.connection do |connection|
#   connection.use Tito::OAuth2Middleware, lambda { |env| Tito.api_key }
# end