# frozen_string_literal: true

module Stores
  class Create < ApplicationService
    ATTRIBUTES = %i[name url locales].freeze

    attr_accessor :admin_account, :fingerprint
    attr_writer :payload

    validate do
      validate_model(store, :base, *ATTRIBUTES)
      validate_model(relationship_service, :base)
    end

    def store
      @_store ||= Store.new(
        created_by: fingerprint,
        updated_by: fingerprint,
        package: package # FIXME
      ).tap do |store|
        store.assign_attributes(payload.slice(*ATTRIBUTES))
      end
    end

    def payload
      @_payload ||= @payload || {}
    end

    def example_store?
      # Rails sends checkbox
      payload[:example_store] != '0'
    end

    protected

    def perform
      store.save!
      relationship_service.save!
      Stores::ExampleStore.new(store: store, fingerprint: fingerprint).save! if example_store?
      create_index_page unless example_store?
    end

    private

    def relationship_service
      @_relationship_service ||= AdminStoreRelationships::Create.new(
        admin_account: admin_account,
        store: store,
        type_key: AdminStoreRelationship::TypeKeys::ADMIN,
        fingerprint: fingerprint
      )
    end

    def create_index_page # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      PageTemplate.create!(store: store, key: 'index', based_on: 'store', status: 'active', created_by: fingerprint,
                           updated_by: fingerprint).tap do |template|
        PageTranslation.create!(store: store, page_template: template, locale: 'en', content: 'Under construction.',
                                created_by: fingerprint)
        PageTranslation.create!(store: store, page_template: template, locale: 'et', content: 'Ehitusel.',
                                created_by: fingerprint)
        PageTranslation.create!(store: store, page_template: template, locale: 'ru', content: 'Under construction.',
                                created_by: fingerprint)
        Page.create!(store: store, key: 'index', url: 'index', page_template: template, status: 'live',
                     created_by: fingerprint, updated_by: fingerprint)
      end
    end

    def package
      @_package ||= Package.find_by!(key: 'pro')
    end
  end
end
