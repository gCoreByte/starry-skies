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

    protected

    def perform
      store.save!
      relationship_service.save!
      create_index_page
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

    def create_index_page
      index_page_template_service.page_template.status = PageTemplate::Statuses::ACTIVE
      index_page_template_service.save!
      index_page_service.save!
    end

    def index_page_service
      @_index_page_service ||=
        Pages::Create.new(
          store: store,
          page_template: index_page_template_service.page_template,
          fingerprint: fingerprint,
          payload: page_params
        )
    end

    def page_params
      {
        key: 'index',
        url: 'index'
      }
    end

    def index_page_template_service
      @_index_page_template_service ||= PageTemplates::Create.new(store: store, fingerprint: fingerprint,
                                                                  payload: page_template_params)
    end

    def page_template_params
      {
        content: '<h1>This store is currently under construction.</h1>',
        key: 'index',
        based_on: 'store'
      }
    end

    def package
      @_package ||= Package.find_by!(key: 'pro')
    end
  end
end
