module Tito
  class WebhookEndpoint < Tito::Base
    include Eventable

    property :url,      type: :string
  end
end