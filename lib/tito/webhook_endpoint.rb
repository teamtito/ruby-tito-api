module Tito
  class WebhookEndpoint < Tito::Base
    extend Eventable

    belongs_to :event

    property :url, type: :string

    # def event=(event_object)
    #   event_id = event_object.id
    #   account_id = event_object.account_id
    # end
  end
end