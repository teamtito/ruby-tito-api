require 'test_helper'

class ReleaseTest < Minitest::Test

  def test_meta
    stub_tito_request("releases")
    events = Tito::Release["paulca/awesomeconf"].all
    assert_equal 2, events.meta["total_pages"]
  end

  def test_all
    stub_request(:get, "https://dashboard.tito.dev/paulca/awesomeconf/releases").
  with(:headers => {'Accept'=>'application/json', 'Authorization'=>'Token token="bilbo"', 'Connection'=>'close', 'Host'=>'dashboard.tito.dev', 'User-Agent'=>'http.rb/2.2.1'}).
  to_return(:status => 200, :body => {releases: []}.to_json, :headers => {content_type: "application/json"})
    events = Tito::Release["paulca/awesomeconf", api_key: "bilbo"].all
  end
end