require 'test_helper'

class EventTest < Minitest::Test

  def get_getting_event
    event = Tito::Event.get("paulca/awesomeconf")
    assert_equal "AwesomeConf 👍", event.title
  end

  def test_assigning_attributes
    event = Tito::Event.new(account_slug: 'paulca')
    assert_equal 'paulca', event.account_slug
  end

  def test_the_path_for_new_event
    event = Tito::Event.new(account_slug: 'paulca')
    assert_equal 'paulca/events', event.post_path
  end

  def test_the_path_for_existing_event
    event = Tito::Event.new(id: 1, account_slug: 'paulca', slug: 'awesomeconf')
    assert_equal 'paulca/awesomeconf', event.put_path
  end

  def test_account_slug_as_method
    event = Tito::Event.new
    event.account_slug = 'awesomeconf'
    assert_equal 'awesomeconf', event.account_slug
  end

  def test_live_get
    stub_request(:get, "https://dashboard.tito.dev/paulca/awesomeconf")
      .to_return(body: fixture('awesomeconf.json'), headers: {content_type: 'application/json; charset=utf-8'})
    event = Tito::Event.get("paulca/awesomeconf")
    assert_equal "AwesomeConf 👍", event.title
  end
end
