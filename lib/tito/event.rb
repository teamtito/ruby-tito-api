module Tito
  class Event < Base    
    belongs_to :account

    property :title, type: :string
    property :security_token, type: :string

    def account_id
      attributes['account_id'] || attributes['account-id']
    end

    def account_id=(val)
      attributes['account_id'] = val
    end

    def security_token
      attributes['security_token'] || attributes['security-token']
    end

    class << self

      def get(path)
        parts = path.split('/')
        where(account_id: parts[0]).find(parts[1]).first
      end

      def path(params=nil)
        prefix_path = '%{account_id}'
        path_params = params.delete(:path) || params
        parts = [].unshift(prefix_path % path_params.symbolize_keys)
        if !params[:id]
          parts << 'events'
        end
        File.join(*parts)
        rescue KeyError
          raise ArgumentError, "Please make sure to include account_id"
      end
    end
  end
end