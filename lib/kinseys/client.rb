require 'kinseys/api'
require 'kinseys/items'
require 'kinseys/order'
require 'kinseys/shipping'

module Kinseys
  class Client < Base

    include Kinseys::API

    attr_accessor :access_token

    def initialize(options = {})
      requires!(options, :username, :password)
      @options = options

      authenticate!
    end

    def items
      @items ||= Kinseys::Items.new(self)
    end

    def order
      @order ||= Kinseys::Order.new(self)
    end

    def shipping
      @shipping ||= Kinseys::Shipping.new(self)
    end

    private

    def authenticate!
      response = post_request(
        'authentication/login',
        { email: @options[:username], password: @options[:password] },
        content_type_header('application/json')
      )

      if response[:token].present?
        self.access_token = response[:token]
      else
        raise Kinseys::Error::NotAuthorized.new(response.body)
      end
    end

  end
end
