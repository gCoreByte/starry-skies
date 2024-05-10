# frozen_string_literal: true

module PurchaseCartStatuses
  class Billed < PurchaseCartStatuses::Base
    def from_statuses
      [
        PurchaseCart::Statuses::CREATED
      ]
    end

    def to_status
      PurchaseCart::Statuses::BILLED
    end
  end
end
