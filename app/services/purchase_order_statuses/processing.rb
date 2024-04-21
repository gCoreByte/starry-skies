# frozen_string_literal: true

module PurchaseOrderStatuses
  class Processing < PurchaseOrderStatuses::Base
    def from_statuses
      [
        PurchaseOrder::Statuses::CREATED
      ]
    end

    def to_status
      PurchaseOrder::Statuses::PROCESSING
    end
  end
end
