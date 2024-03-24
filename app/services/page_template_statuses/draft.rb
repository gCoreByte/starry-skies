# frozen_string_literal: true

module PageTemplateStatuses
  class Draft < PageTemplateStatuses::Base
    def status
      PageTemplate::Statuses::DRAFT
    end

    def from_statuses
      [PageTemplate::Statuses::ACTIVE]
    end
  end
end
