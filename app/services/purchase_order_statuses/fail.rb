# frozen_string_literal: true

module PurchaseOrderStatuses
  class Fail < PurchaseOrderStatuses::Base
    def from_statuses
      [
        PurchaseOrder::Statuses::CREATED,
        PurchaseOrder::Statuses::PROCESSING,
        PurchaseOrder::Statuses::IN_TRANSIT
      ]
    end

    def to_status
      PurchaseOrder::Statuses::FAILED
    end
  end
end
