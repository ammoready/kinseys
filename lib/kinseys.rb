require 'kinseys/base'
require 'kinseys/version'

require 'kinseys/api'
require 'kinseys/catalog'
require 'kinseys/client'
require 'kinseys/error'
require 'kinseys/inventory'
require 'kinseys/items'
require 'kinseys/order'
require 'kinseys/response'
require 'kinseys/shipping'
require 'kinseys/user'

module Kinseys

  class << self
    attr_accessor :config
  end

  def self.config
    @config ||= Configuration.new
  end

  def self.configure
    yield(config)
  end

  class Configuration
    attr_accessor :proxy_address
    attr_accessor :proxy_port

    def initialize
      @proxy_address ||= nil
      @proxy_port    ||= nil
    end
  end

end
