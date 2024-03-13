# frozen_string_literal: true

module ProductPrices
  class Destroy < ApplicationService
    attr_accessor :product_price, :fingerprint

    validates :product_price, :fingerprint, presence: true

    protected

    def perform
      product_price.destroy!
    end
  end
end
