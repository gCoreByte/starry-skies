# frozen_string_literal: true

FactoryBot.define do
  factory :admin_store_relationship do
    store { association(:store) }
    admin_account { association(:admin_account) }
    type_key { AdminStoreRelationship::TypeKeys::ADMIN }
    created_by { association(:fingerprint) }

    AdminStoreRelationship::TypeKeys::ALL.each do |type_key|
      trait type_key.to_sym do
        type_key { type_key }
      end
    end
  end
end
