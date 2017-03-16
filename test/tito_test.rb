require 'test_helper'

class TitoTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Tito::VERSION
  end

  def test_that_it_gets_api_key_from_env
    before = ENV['TITO_API_KEY']
    ENV['TITO_API_KEY'] = 'blah'
    assert_equal "blah", Tito.api_key
    ENV['TITO_API_KEY'] = before
  end
end