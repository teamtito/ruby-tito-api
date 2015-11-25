module Tito
  class OAuth2Middleware < FaradayMiddleware::OAuth2
    def call(env)
      computed_token = if @token.is_a?(Proc)
        @token.call(env)
      else
        @token
      end

      computed_token ||= Tito.api_key

      params = { param_name => computed_token }.update query_params(env[:url])
      token = params[param_name]

      if token.respond_to?(:empty?) && !token.empty?
        env[:url].query = build_query params
        env[:request_headers][AUTH_HEADER] ||= %(Token token="#{token}")
      end

      @app.call env
    end

    def initialize(app, token = nil, options = {})
      super(app)
      options, token = token, nil if token.is_a? Hash
      @token = token
      @param_name = options.fetch(:param_name, PARAM_NAME).to_s
      raise ArgumentError, ":param_name can't be blank" if @param_name.empty?
    end
  end
end