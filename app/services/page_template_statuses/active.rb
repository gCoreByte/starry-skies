# frozen_string_literal: true

module PageTemplateStatuses
  class Active < PageTemplateStatuses::Base
    def status
      PageTemplate::Statuses::ACTIVE
    end

    def from_statuses
      [PageTemplate::Statuses::DRAFT]
    end
  end
end
