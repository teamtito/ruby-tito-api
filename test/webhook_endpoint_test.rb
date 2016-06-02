require 'test_helper'

class WebhookEndpointTest < Minitest::Test

  def event
    Tito::Event.new(account_id: 'paulca', id: 'awesomeconf')
  end

  def test_the_path_for_all_webhook_endpoints
    Tito::WebhookEndpoint.where(account_id: 'paulca', event_id: 'awesomeconf').all
  end

  def test_the_path_for_new_webhook_endpoint
    webhook_endpoint = Tito::WebhookEndpoint.new(event: event)
    assert_equal 'paulca/awesomeconf/webhook_endpoints', webhook_endpoint.class.requestor.send(:resource_path, webhook_endpoint.attributes)
  end

  def test_the_path_for_existing_webhook_endpoint
    event.mark_as_persisted!
    webhook_endpoint = Tito::WebhookEndpoint.new(event: event, id: 1234)
    webhook_endpoint.mark_as_persisted!
    assert_equal 'paulca/awesomeconf/webhook_endpoints/1234', webhook_endpoint.class.requestor.send(:resource_path, webhook_endpoint.attributes)
  end
end
