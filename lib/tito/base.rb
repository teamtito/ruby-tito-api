module Tito
  class Base < JsonApiClient::Resource
    self.site = ENV['TITO_SITE'] || "https://api.tito.io/v2"
  end
end