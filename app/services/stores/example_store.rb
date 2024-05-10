# frozen_string_literal: true

module Stores
  # Creates an example store for fruits and vegetables.
  class ExampleStore < ApplicationService # rubocop:disable Metrics/ClassLength
    attribute :time, :datetime, default: -> { Time.zone.now }
    attr_accessor :store, :fingerprint

    validates :store, :fingerprint, presence: true

    CATEGORIES = %w[Fruits Vegetables Spices].freeze
    PRODUCTS = %w[apple pear carrot cinnamon].freeze
    USER_GROUPS = %w[loyal special].freeze
    PRODUCT_TO_CATEGORY = {
      'apple' => 'Fruits',
      'pear' => 'Fruits',
      'carrot' => 'Vegetables',
      'cinnamon' => 'Spices'
    }.freeze

    def perform
      records.flatten.each(&:save!)
    end

    def records
      [
        categories, user_groups, products, product_versions, product_version_categories, product_prices,
        index_page_records, products_page_records, product_page_records, category_page_records, cart_show_records
      ]
    end

    private

    def categories
      @_categories ||= CATEGORIES.map { |name| build_category(name) }
    end

    def products
      @_products ||= PRODUCTS.map { |key| build_product(key) }
    end

    def product_versions
      @_product_versions ||= products.map { |p| build_product_version(p) }
    end

    def product_version_categories
      @_product_version_categories ||= product_versions.map do |pv|
        build_product_version_category(pv, categories.find { |c| c.name == PRODUCT_TO_CATEGORY[pv.product.key] })
      end
    end

    def user_groups
      @_user_groups ||= USER_GROUPS.map { |name| build_user_group(name) }
    end

    def product_prices
      @_product_prices ||= product_versions.map { |pv| build_product_prices(pv) }.flatten
    end

    def index_page_records
      @_index_page_records ||= Stores::ExamplePages::Index.new(store: store, fingerprint: fingerprint).records
    end

    def products_page_records
      @_products_page_records ||= Stores::ExamplePages::ProductIndex.new(store: store, fingerprint: fingerprint).records
    end

    def product_page_records
      @_product_page_records ||= Stores::ExamplePages::ProductShow.new(store: store, fingerprint: fingerprint).records
    end

    def category_page_records
      @_category_page_records ||= Stores::ExamplePages::CategoryShow.new(store: store, fingerprint: fingerprint).records
    end

    def cart_show_records
      @_cart_show_records ||= Stores::ExamplePages::PurchaseCartShow.new(store: store, fingerprint: fingerprint).records
    end

    def build_category(name)
      ProductCategory.new(
        store: store,
        created_by: fingerprint,
        updated_by: fingerprint,
        name: name,
        key: name.downcase
      )
    end

    def build_product(key)
      Product.new(
        store: store,
        created_by: fingerprint,
        updated_by: fingerprint,
        key: key
      )
    end

    def build_product_version(product)
      ProductVersion.new(
        product: product,
        store: store,
        version: 1,
        created_by: fingerprint,
        updated_by: fingerprint,
        activated_at: time,
        activated_by: fingerprint,
        translations: translation(product.key)
      )
    end

    def build_product_version_category(product_version, category)
      ProductVersionCategory.new(
        product_version: product_version,
        product_category: category,
        store: store,
        created_by: fingerprint
      )
    end

    def build_user_group(name)
      UserGroup.new(
        store: store,
        name: name,
        key: name.downcase,
        ranking: name.length
      )
    end

    def build_product_prices(product_version)
      [
        build_product_price(product_version, user_groups[0]),
        build_product_price(product_version, user_groups[1])
      ]
    end

    def build_product_price(product_version, user_group)
      ProductPrice.new(
        store: store,
        product_version: product_version,
        user_group: user_group,
        price: rand(1.0..25.0).truncate(2),
        created_by: fingerprint,
        updated_by: fingerprint
      )
    end

    def translation(product_name) # rubocop:disable Metrics/MethodLength
      {
        et: {
          name: "Eesti #{product_name.capitalize}",
          description: "Eesti #{product_name.capitalize} on hea toode."
        },
        en: {
          name: "English #{product_name.capitalize}",
          description: "English #{product_name.capitalize} is a good product."
        },
        ru: {
          name: "Russian #{product_name.capitalize}",
          description: "Russian #{product_name.capitalize} is a good product."
        }
      }
    end
  end
end
