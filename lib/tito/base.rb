module Tito
  class Base
    attr_accessor :path_prefix
    def self.site
      @site || ENV['TITO_SITE'] || "https://api.tito.io/v2"
    end

    def self.site=(val)
      @site = val
    end

    def self.auth(api_key: nil)
      token = api_key || Tito.api_key
      raise "API key is required" if !token
      if token.length > 30
        %(Bearer #{token})
      else
        %(Token token="#{token}")
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

    def self.http(api_key: nil)
      HTTP[user_agent: "Tito Ruby API #{Tito::VERSION}"].auth(auth(api_key: api_key)).accept("application/json")
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

    def self.resource_path(*args)
      @resource_path ||= "#{resource_name}s"
    end

    def self.get_path(path, path_prefix: nil)
      [path_prefix, self.resource_path, path].compact.join("/")
    end

    def self.get_url(path, path_prefix: nil)
      [Tito::Base.site, get_path(path, path_prefix: path_prefix)].join("/")
    end

    def self.get(path, params = {})
      api_key = params.delete(:api_key)
      path_prefix = params.delete(:path_prefix)
      new http(api_key: api_key).get(get_url(path, path_prefix: path_prefix), params: ParamNester.encode(params), ssl_context: ssl_context).parse[resource_name]
    end

    def self.all_path(path_prefix: nil)
      [path_prefix, resource_path(:all)].compact.join("/")
    end

    def self.all_url(path_prefix: nil)
      [site, all_path(path_prefix: path_prefix)].join("/")
    end

    def self.all(params = {})
      api_key = params.delete(:api_key)
      path_prefix = params.delete(:path_prefix)
      response = http(api_key: api_key).get(all_url(path_prefix: path_prefix), params: ParamNester.encode(params), ssl_context: ssl_context).parse
      all_records = response[self.resource_path(:all)]
      meta = response["meta"]
      out = ResponseArray.new(all_records.collect do |record|
        new record
      end)
      out.meta = meta
      out
    end

    def initialize(attrs = {})
      self.path_prefix = (attrs ||= {}).delete(:path_prefix)
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

    def auth(api_key: nil)
      self.class.auth(api_key: api_key)
    end

    def http(api_key: nil)
      self.class.http(api_key: api_key)
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

    def save(api_key: nil)
      if persisted?
        attrs = http(api_key: api_key).put(put_url, json: {self.class.resource_name => attributes}, ssl_context: ssl_context).parse[self.class.resource_name]
      else
        attrs = http(api_key: api_key).post(post_url, json: {self.class.resource_name => attributes}, ssl_context: ssl_context).parse[self.class.resource_name]
      end
      self.attributes = attrs
    end

    def destroy(api_key: nil)
      http(api_key: api_key).delete(put_url, ssl_context: ssl_context)
    end

    # cf. https://github.com/sumofparts/lifter/commit/e224946538ea0be337b7418c2946dbf1c2018b6b
    module ParamNester
      def self.encode(value, key = nil, out_hash = {})
        case value
        when Hash
          value.each { |k,v| encode(v, append_key(key, k), out_hash) }
          out_hash
        when Array
          value.each { |v| encode(v, "#{key}[]", out_hash) }
          out_hash
        when nil
          ''
        else
          out_hash[key] = value
          out_hash
        end
      end

      def self.append_key(root_key, key)
        root_key.nil? ? :"#{key}" : :"#{root_key}[#{key.to_s}]"
      end
    end
  end
end