# frozen_string_literal: true

module PurchaseOrderStatuses
  class InTransit < PurchaseOrderStatuses::Base
    def from_statuses
      [
        PurchaseOrder::Statuses::PROCESSING
      ]
    end

    def to_status
      PurchaseOrder::Statuses::IN_TRANSIT
    end
  end
end
