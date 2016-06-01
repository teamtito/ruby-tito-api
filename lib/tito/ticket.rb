module Tito
  class Ticket < Tito::Base
    include Eventable

    property :url,              type: :string
    property :name,             type: :string
    property :email,            type: :string

    property :company_name,     type: :string
    
    property :metadata,         type: :string
    
    property :number,           type: :integer
    property :phone_number,     type: :string
    property :price,            type: :string
    property :reference,        type: :string
    property :state,            type: :string
    property :tags,             type: :string
    property :test_mode,        type: :boolean
  end
end