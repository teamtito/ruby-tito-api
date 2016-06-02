module Tito
  module Eventable

    def self.included(base)
      base.extend ClassMethods
      base.class_eval do
        property :event
        property :event_id
      end
    end

    def event=(tito_event)
      self.event_id = tito_event.id
      self.attributes[:event] = tito_event
      @event = tito_event
    end

    module ClassMethods

      def event_id_from_params(params)
        return params[:event][:id] if params[:event]
        return params[:filter][:event_id] if params[:filter]
      end

      def account_id_from_params(params)
        return params[:event][:account_id] if params[:event]
        return params[:filter][:account_id] if params[:filter]
      end

      def path(params=nil)
        prefix_path = '%{account_id}/%{event_id}'
        path_params = params.delete(:path) || params
        path_params[:event_id] = event_id_from_params(params)
        path_params[:account_id] = account_id_from_params(params)
        parts = [].unshift(prefix_path % path_params.symbolize_keys)
        parts << params[:type]
        File.join(*parts)
        rescue KeyError
          raise ArgumentError, "Please make sure to include account_id and event_id"
      end
    end
  end
end