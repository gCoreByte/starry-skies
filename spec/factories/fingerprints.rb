# frozen_string_literal: true

FactoryBot.define do
  factory :fingerprint do
    admin_account { association(:admin_account) }
    ip_address { '127.0.0.1' }
    user_agent { 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko)' }
    digest { '1234567890' }
    type_key { Fingerprint::TypeKeys::USER }
  end
end
