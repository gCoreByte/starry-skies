# frozen_string_literal: true

module BasedOns
  class BlogPost < BasedOns::Base
    delegate :store, to: :record

    def provides
      %w[store blog_post]
    end

    def blog_post
      record
    end
  end
end
