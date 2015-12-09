module Tito
  class Event < Base    
    belongs_to :account

    property :title, type: :string

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
          raise ArgumentError, "Please make sure to include account_id"
      end

      # def path(params=nil)
      #   if params[:id].blank?
      #     ['%account_id', 'events'].compact.join('/')
      #   else
      #     '%account_id'
      #   end
      # end
    end
  end
end