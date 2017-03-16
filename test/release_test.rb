require 'test_helper'

class ReleaseTest < Minitest::Test

  def test_meta
    stub_tito_request("releases")
    events = Tito::Release["paulca/awesomeconf"].all
    assert_equal 2, events.meta["total_pages"]
  end
end