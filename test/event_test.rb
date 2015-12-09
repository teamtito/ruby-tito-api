require 'test_helper'

class EventTest < Minitest::Test
  def test_the_path
    event = Tito::Event.new
    assert_equal '/events', event.class.requestor.send(:resource_path, event.attributes)
  end
end
