require 'test_helper'

class WebhookEndpointTest < Minitest::Test

  def event
    Tito::Event.new(account_id: 'paulca', id: 'awesomeconf')
  end

  def test_the_path_for_new_webhook_endpoint
    webhook_endpoint = Tito::WebhookEndpoint.new(event: event)
    # byebug
    assert_equal 'paulca/awesomeconf/webhook_endpoints', webhook_endpoint.class.requestor.send(:resource_path, webhook_endpoint.attributes)
  end

  # def test_the_path_for_existing_event
  #   event = Tito::Event.new(account_id: 'paulca', id: 'awesomeconf')
  #   event.mark_as_persisted!
  #   assert_equal 'paulca/awesomeconf', event.class.requestor.send(:resource_path, event.attributes)
  # end
end
