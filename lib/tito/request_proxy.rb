module Tito
  class RequestProxy
    attr_accessor :proxy_path
    attr_accessor :proxy_class
    attr_accessor :api_key

    def initialize(proxy_class: nil, proxy_path: nil, api_key: nil)
      @proxy_path       = proxy_path
      @proxy_class      = proxy_class
      @api_key          = api_key
    end

    def extra_params
      {}.tap do |_extra_params|
        _extra_params[:path_prefix] = proxy_path  if proxy_path.to_s  != ''
        _extra_params[:api_key]     = api_key     if api_key.to_s     != ''
      end
    end

    def get(path, params = {})
      proxy_class.get(path, params.merge(extra_params))
    end

    def all(params = {})
      proxy_class.all(params.merge(extra_params))
    end

    def new(attrs = {})
      proxy_class.new(attrs.merge(extra_params))
    end
  end
end