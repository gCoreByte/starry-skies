# frozen_string_literal: true

module Variables
  class Store < BasedOns::Base
    VARIABLES = %w[products].freeze

    def variables
      VARIABLES
    end

    def products
      @_products ||= record.products.active.map do |product|
        Variables::VariableProvider.new(record: product)
      end
    end

    # TODO: implement me
    # def blog_posts
    #   record.blog_posts.published
    # end
  end
end
