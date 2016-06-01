module Tito
  class Account < Base
    property :name, type: :string
    property :description, type: :string
    property :slug, type: :string

    def events
      Tito::Event.where(account_id: id)
    end
  end
end