class Offer < ActiveRecord::Base
  def self.retrieve
    # JSON.parse(RestClient.get('https://p-webapi.movetv.com/catalog/offers',:verify_ssl => false))
    JSON.parse(RestClient::Request.execute(method: :get, url: 'https://p-webapi.movetv.com/catalog/offers', verify_ssl: false))
  end
end
