module Tito
  module Eventable

    def self.included(base)
      base.extend ClassMethods
      base.class_eval do
        attr_accessor :event_slug
        attr_accessor :account_slug
      end
    end

    def put_path
      [path_prefix, self.class.resource_path, id].join("/")
    end

    def post_path
      [path_prefix, self.class.resource_path].join("/")
    end

    # def event=(tito_event)
    #   self.event_id = tito_event.id
    #   self.attributes[:event] = tito_event
    #   @event = tito_event
    # end

    module ClassMethods
      def for_event(url)
        RequestProxy.new(proxy_class: self, proxy_path: url)
      end

      def [](url)
        self.for_event(url)
      end

    #   def event_id_from_params(params)
    #     return params[:event][:slug] if params[:event]
    #     return params[:filter][:event_id] if params[:filter]
    #   end

    #   def account_id_from_params(params)
    #     return params[:event]["account-slug"] if params[:event]
    #     return params[:filter][:account_id] if params[:filter]
    #   end

    #   def path(params=nil)
    #     prefix_path = '%{account_id}/%{event_id}'
    #     path_params = params.delete(:path) || params
    #     path_params[:event_id] = event_id_from_params(params)
    #     path_params[:account_id] = account_id_from_params(params)
    #     parts = [].unshift(prefix_path % path_params.symbolize_keys)
    #     parts << table_name

    #     File.join(*parts)

    #     rescue KeyError
    #       raise ArgumentError, "Please make sure to include account_id and event_id"
    #   end
    end
  end
end