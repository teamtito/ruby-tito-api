module Tito
  class Base < JsonApiClient::Resource
    # set the api base url in an abstract base class
    # self.site = "https://api.tito.io/"
    self.site = "http://api.tito.dev/"
  end
end