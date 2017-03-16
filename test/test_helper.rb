$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'tito'
require 'byebug'

require 'minitest/autorun'

require 'webmock/minitest'
WebMock.disable_net_connect!

require 'dotenv'
Dotenv.load('.env')

ctx = OpenSSL::SSL::SSLContext.new
ctx.verify_mode = OpenSSL::SSL::VERIFY_NONE
Tito::Base.ssl_context = ctx


def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

def stub_tito_request(path)
  stub_request(:get, "https://dashboard.tito.dev/paulca/awesomeconf/#{path}")
      .to_return(body: fixture("#{path}.json"), headers: {content_type: 'application/json; charset=utf-8'})
end