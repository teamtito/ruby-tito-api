module Tito
  class JsonRequest < Faraday::Middleware
    def call(environment)
      environment[:request_headers]["Content-Type"] = 'application/vnd.tito.v2+json'
      environment[:request_headers]["Accept"] = 'application/vnd.tito.v2+json'
      @app.call(environment)
    end
  end
end
