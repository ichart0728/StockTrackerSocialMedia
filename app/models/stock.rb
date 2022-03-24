class Stock < ApplicationRecord

    # self.method_name <- Class Method, it can be used it like Stock.new_lookup
    def self.new_lookup(ticker_symbol)
        client = IEX::Api::Client.new(
            #publishable_token: It's stored in config/credentials.yml.enc 
            publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
            endpoint: 'https://sandbox.iexapis.com/v1'
        )
        client.price(ticker_symbol)
    end
end
