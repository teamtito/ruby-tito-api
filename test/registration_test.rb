require 'test_helper'

class RegistrationTest < Minitest::Test
  def test_live_registration_with_prefix
    stub_request(:get, "https://dashboard.tito.dev/paulca/awesomeconf/registrations/p1PX0g0MDeIMOxa8LOqglzw")
      .to_return(body: fixture('registration.json'), headers: {content_type: 'application/json; charset=utf-8'})
    registration = Tito::Registration["paulca/awesomeconf"].get("p1PX0g0MDeIMOxa8LOqglzw")
    assert_equal "Paul Campbell", registration.name
  end

  def test_live_registration_without_prefix
    stub_request(:get, "https://dashboard.tito.dev/registrations/p1PX0g0MDeIMOxa8LOqglzw")
      .to_return(body: fixture('registration.json'), headers: {content_type: 'application/json; charset=utf-8'})
    registration = Tito::Registration.get("p1PX0g0MDeIMOxa8LOqglzw")
    assert_equal "Paul Campbell", registration.name
  end
end