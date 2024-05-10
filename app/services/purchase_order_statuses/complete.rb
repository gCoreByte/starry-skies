# frozen_string_literal: true

module PurchaseOrderStatuses
  class Complete < PurchaseOrderStatuses::Base
    def from_statuses
      [
        PurchaseOrder::Statuses::IN_TRANSIT
      ]
    end

    def to_status
      PurchaseOrder::Statuses::COMPLETED
    end
  end
end
