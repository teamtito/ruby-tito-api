require 'test_helper'

class WebhookEndpointTest < Minitest::Test

  def event
    Tito::Event.new(account_id: 'paulca', id: 'awesomeconf')
  end

  def test_the_path_for_all_webhook_endpoints
    stub_tito_request("webhook_endpoints")
    Tito::WebhookEndpoint.for_event("paulca/awesomeconf").all
    Tito::WebhookEndpoint["paulca/awesomeconf"].all
  end

  def test_the_path_for_new_webhook_endpoint
    webhook_endpoint = Tito::WebhookEndpoint["paulca/awesomeconf"].new
    assert_equal 'paulca/awesomeconf/webhook_endpoints', webhook_endpoint.post_path
  end

  def test_the_path_for_existing_webhook_endpoint
    webhook_endpoint = Tito::WebhookEndpoint["paulca/awesomeconf"].new("id" => 1234)
    assert_equal 'paulca/awesomeconf/webhook_endpoints/1234', webhook_endpoint.put_path
  end
end
