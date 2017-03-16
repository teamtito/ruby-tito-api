module Tito
  class RequestProxy
    attr_accessor :proxy_event_url
    attr_accessor :proxy_class

    def initialize(proxy_class: nil, proxy_event_url: nil)
      @proxy_event_url = proxy_event_url
      @proxy_class = proxy_class
    end

    def all
      proxy_class.all(event_path: proxy_event_url)
    end

    def new(attrs = {})
      proxy_class.new(attrs.merge(event_path: proxy_event_url))
    end
  end
end