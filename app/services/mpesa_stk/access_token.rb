require "base64"
require "json"
require "faraday"
require "uri"
require "net/http"

module MpesaStk
  class AccessToken
    def self.call
      new.fetch_access_token
    end

    def fetch_access_token
      consumer_credentials = credentials
      keys = Base64.strict_encode64(consumer_credentials)

      response = Faraday.get(url) do |req|
        req.headers["Authorization"] = "Basic #{keys}"
      end

      res = JSON.parse(response.body)
      res["access_token"]
    end

    private

    def url
      URI("https://sandbox.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials")
    end

    def credentials
      consumer_key = Rails.application.credentials.mpesa.fetch(:key)
      consumer_secret = Rails.application.credentials.mpesa.fetch(:secret)
      "#{consumer_key}:#{consumer_secret}"
    end
  end
end
