class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :user, through: :user_stocks

  validates :name, :ticker, presence: true
  # self.method_name <- Class Method, it can be used it like Stock.new_lookup
  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      #publishable_token: It's stored in config/credentials.yml.enc 
      publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
      endpoint: 'https://sandbox.iexapis.com/v1'
    )

    begin
      new(ticker: ticker_symbol, name: client.company(ticker_symbol).company_name, last_price: client.price(ticker_symbol))
    rescue => exception
      return nil
    end
  end

  def self.check_db(ticker_symbol)
    # Don't need Stock before where() since its already in the Stock model
    where(ticker: ticker_symbol).first
  end

end
