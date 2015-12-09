require 'test_helper'

class EventTest < Minitest::Test
  def test_the_path_for_new_event
    event = Tito::Event.new
    assert_equal 'events', event.class.requestor.send(:resource_path, event.attributes)
  end

  def test_the_path_for_existing_event
    event = Tito::Event.new(account_id: 'paulca', id: 'awesomeconf')
    event.mark_as_persisted!
    assert_equal 'paulca/awesomeconf', event.class.requestor.send(:resource_path, event.attributes)
  end
end
