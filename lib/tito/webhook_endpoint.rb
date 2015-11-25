module Tito
  class WebhookEndpoint < Tito::Base
    belongs_to :event

    property :url, type: :string
    property :event_id, type: :int
  end
end