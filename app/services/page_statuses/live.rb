# frozen_string_literal: true

module PageStatuses
  class Live < PageStatuses::Base
    def status
      Page::Statuses::LIVE
    end

    def from_statuses
      [Page::Statuses::DRAFT]
    end
  end
end
