module Tito
  class Event < Base    
    belongs_to :account

    property :title, type: :string
  end
end