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

    def all
      proxy_class.all(path_prefix: proxy_path, api_key: api_key)
    end

    def new(attrs = {})
      proxy_class.new(attrs.merge(path_prefix: proxy_path, api_key: api_key))
    end
  end
end