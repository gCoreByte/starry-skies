# frozen_string_literal: true

module Variables
  class BlogPost < Variables::Base
    delegate :id, :title, :content, :markdown_content, to: :record

    def variables
      %w[id title content markdown_content]
    end

    def store
      Variables::VariableProvider.new(record: based_on_service.store)
    end
  end
end
