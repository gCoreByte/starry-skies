# frozen_string_literal: true

module PurchaseCartStatuses
  class Expire < PurchaseCartStatuses::Base
    def from_statuses
      [
        PurchaseCart::Statuses::CREATED,
        PurchaseCart::Statuses::BOOKED
      ]
    end

    def to_status
      PurchaseCart::Statuses::EXPIRED
    end
  end
end
