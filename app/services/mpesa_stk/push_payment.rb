require "base64"
require "json"
require_relative "./access_token"
require "faraday"

module MpesaStk
  class PushPayment
    class << self
      def call(amount, phone)
        new(amount, phone).push_payment
      end
    end

    attr_reader :token, :amount, :phone

    def initialize(amount, phone)
      @token = MpesaStk::AccessToken.call
      @amount = amount
      @phone = phone
    end

    def push_payment
      response = Faraday.post(url, body) do |req|
        req.headers["Content-Type"] = "application/json"
        req.headers["Authorization"] = "Bearer #{token}"
      end
      JSON.parse(response.body)
    end

    private

    def url
      base_url = Rails.application.credentials.mpesa.fetch(:base_url)
      token_generator_url = Rails.application.credentials.mpesa.fetch(:process_request_url)
      "#{base_url}#{token_generator_url}"
    end

    def body
      {
        BusinessShortCode: Rails.application.credentials.mpesa.fetch(:business_short_code),
        Password: generate_password,
        Timestamp: timestamp.to_s,
        TransactionType: "CustomerPayBillOnline",
        Amount: amount.to_s,
        PartyA: phone,
        PartyB: Rails.application.credentials.mpesa.fetch(:business_short_code),
        PhoneNumber: phone,
        CallBackURL: Rails.application.credentials.mpesa.fetch(:callback_url),
        AccountReference: generate_bill_reference_number(5),
        TransactionDesc: generate_bill_reference_number(5)
      }.to_json
    end

    def generate_bill_reference_number(number)
      charset = Array("A".."Z") + Array("a".."z")
      Array.new(number) { charset.sample }.join
    end

    def timestamp
      DateTime.now.strftime("%Y%m%d%H%M%S").to_i
    end

    def generate_password
      business_short_code = Rails.application.credentials.mpesa.fetch(:business_short_code)
      business_passkey = Rails.application.credentials.mpesa.fetch(:business_passkey)
      key = "#{business_short_code}#{business_passkey}#{timestamp}"
      Base64.encode64(key).split("\n").join
    end
  end
end
