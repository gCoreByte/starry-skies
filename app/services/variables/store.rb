# frozen_string_literal: true

module Variables
  class Store < Variables::Base
    def variables
      %w[id name products]
    end

    delegate :id, :name, to: :record

    def products
      @_products ||= record.products.active.map do |product|
        Variables::VariableProvider.new(record: product)
      end
    end

    def product_categories
      @_product_categories ||= record.product_categories.map do |product_category|
        Variables::VariableProvider.new(record: product_category)
      end
    end

    # TODO: implement me
    # def blog_posts
    #   record.blog_posts.published
    # end
  end
end
