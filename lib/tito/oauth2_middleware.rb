module Tito
  class OAuth2Middleware < FaradayMiddleware::OAuth2
    def call(env)
      token = if @token.is_a?(Proc)
        @token.call(env)
      else
        @token
      end

      token ||= Tito.api_key

      params = query_params(env[:url])

      if token.respond_to?(:empty?) && !token.empty?
        env[:url].query = build_query params
        env[:request_headers][AUTH_HEADER] ||= %(Bearer #{token})
      end

      @app.call env
    end

    def initialize(app, token = nil, options = {})
      super(app)
      options, token = token, nil if token.is_a? Hash
      @token = token
      raise ArgumentError, ":param_name can't be blank" if @param_name.empty?
    end
  end
end