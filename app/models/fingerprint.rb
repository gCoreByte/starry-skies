# frozen_string_literal: true

class Fingerprint < ApplicationRecord
  module TypeKeys
    SYSTEM = 'system'
    CONSOLE = 'console'
    USER = 'user'
    ALL = [SYSTEM, CONSOLE, USER].freeze
  end

  belongs_to :admin_account, optional: true

  validates :type_key, presence: true
  validates :ip_address, length: { maximum: 15 }, allow_nil: true
  validates :digest, length: { maximum: 64 }, allow_nil: true
  validates :user_agent, length: { maximum: 1000 }, allow_nil: true

  TypeKeys::ALL.each do |key|
    define_method("#{key}?") do
      key == type_key
    end

    scope key.to_sym, -> { where(type_key: key) }
  end

  class << self
    def from_user(admin_account, ip_address, user_agent)
      Fingerprint.find_or_create_by!(
        type_key: TypeKeys::USER,
        admin_account: admin_account,
        ip_address: ip_address,
        user_agent: user_agent,
        digest: Digest::SHA256.hexdigest("#{ip_address}#{user_agent}")
      )
    end

    def from_system
      Fingerprint.find_or_create_by!(
        type_key: TypeKeys::SYSTEM,
        ip_address: '127.0.0.1',
        user_agent: 'System',
        digest: Digest::SHA256.hexdigest('127.0.0.1System')
      )
    end

    def from_console
      ip_address = ENV['SSH_CONNECTION']&.split(' ', 2)&.first
      user_agent = [ENV.fetch('USER', nil), Socket.gethostname].join('@')
      Fingerprint.find_or_create_by!(
        type_key: TypeKeys::CONSOLE,
        ip_address: ip_address,
        user_agent: user_agent,
        digest: Digest::SHA256.hexdigest("#{ip_address}#{user_agent}")
      )
    end
  end
end
