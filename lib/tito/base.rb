module Tito
  class Base
    attr_accessor :path_prefix
    def self.site
      @site || ENV['TITO_SITE'] || "https://api.tito.io/v2"
    end

    def self.site=(val)
      @site = val
    end

    def self.auth
      raise "API key is required" if !Tito.api_key
      if Tito.api_key.length > 30
        %(Bearer #{Tito.api_key})
      else
        %(Token token="#{Tito.api_key}")
      end
    end

    def self.ssl_context
      @ssl_context ||= begin
        ctx = OpenSSL::SSL::SSLContext.new
        ctx
      end
    end

    def self.ssl_context=(ctx)
      @ssl_context = ctx
    end

    def self.http
      HTTP.auth(auth).accept("application/json")
    end

    def self.resource_path=(val)
      @resource_path = val
    end

    def self.resource_name=(val)
      @resource_name = val
    end

    def self.underscore_class_name
      self.to_s.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
    end

    def self.resource_name
      @resource_name ||= underscore_class_name.split("/").last
    end

    def self.resource_path
      @resource_path ||= "#{resource_name}s"
    end

    def self.get(path, params = {})
      url = [site, path].join("/")
      new http.get(url, params: params, ssl_context: ssl_context).parse[resource_name]
    end

    def self.all(params = {})
      path_prefix = params.delete(:event_path)
      url = [site, path_prefix, resource_path].compact.join("/")
      http.get(url, params: params, ssl_context: ssl_context).parse.collect do |record|
        new record
      end
    end

    def initialize(attrs = {})
      self.path_prefix = attrs.delete(:event_path)
      attrs.each do |key, val|
        attributes[key.to_s] = val
      end
    end

    def attributes
      @attributes ||= {}
    end

    def attributes=(attrs)
      @attributes = attrs
    end

    def method_missing(method_name, val = nil)
      if method_name.to_s[-1] == "="
        self.attributes[method_name[0, (method_name.length - 1)]] = val
      else
        self.attributes[method_name.to_s]
      end
    end

    def new_record?
      attributes["id"] == nil
    end

    def persisted?
      !new_record?
    end

    def auth
      self.class.auth
    end

    def http
      self.class.http
    end

    def ssl_context
      self.class.ssl_context
    end

    def put_url
      [Tito::Base.site, put_path].join("/")
    end

    def post_url
      [Tito::Base.site, post_path].join("/")
    end

    def save
      if persisted?
        attrs = http.put(put_url, json: {self.class.resource_name => attributes}, ssl_context: ssl_context).parse[self.class.resource_name]
      else
        attrs = http.post(post_url, json: {self.class.resource_name => attributes}, ssl_context: ssl_context).parse[self.class.resource_name]
      end
      self.attributes = attrs
    end

    def destroy
      http.delete(put_url, ssl_context: ssl_context)
    end

    # def self.with_api_key(api_key, &block)
    #   if block_given?
    #     if api_key.length > 30
    #       authorization = %(Bearer #{api_key})
    #     else
    #       authorization = %(Token token="#{api_key}")
    #     end
    #     with_headers(authorization: authorization, &block)
    #   else
    #     with_params(api_key: api_key)
    #   end
    # end
  end
end