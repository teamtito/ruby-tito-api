module Tito
  class WebhookEndpoint < Tito::Base
    belongs_to :event

    property :url, type: :string

    # def event=(event_object)
    #   event_id = event_object.id
    #   account_id = event_object.account_id
    # end

    class << self
      def path(params=nil)
        prefix_path = '%{account_id}/%{event_id}'
        path_params = params.delete(:path) || params
        path_params[:event_id] = params[:event][:id]
        path_params[:account_id] = params[:event][:account_id]
        parts = [].unshift(prefix_path % path_params.symbolize_keys)
        parts << 'webhook_endpoints'
        File.join(*parts)
        # parts = ['%{account_id}', '%{id}']
        #   if params
        #     path_params = params.delete(:path) || params
        #     parts.unshift(_prefix_path % path_params.symbolize_keys)
        #   else
        #     parts.unshift(_prefix_path)
        #   end
        #   parts.reject!{|part| part == "" }
        #   File.join(*parts)
        rescue KeyError
          raise ArgumentError, "Please make sure to include account_id and event_id"
      end
    end
  end
end