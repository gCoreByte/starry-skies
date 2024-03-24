# frozen_string_literal: true

module PageStatuses
  class Draft < PageStatuses::Base
    def status
      Page::Statuses::DRAFT
    end

    def from_statuses
      [Page::Statuses::LIVE]
    end
  end
end
