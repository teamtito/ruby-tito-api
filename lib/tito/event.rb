module Tito
  class Event < Base    
    belongs_to :account

    property :title, type: :string

    class << self
      def path(params=nil)
        # '%{account_id}/%{id}'
        '/events'
      end
    end
  end
end