# frozen_string_literal: true

module Mixins
  module Translatable
    extend ActiveSupport::Concern

    included do
      validates :translations, hash: true

      def translatable_keys
        TRANSLATABLE_KEYS
      end
    end
  end
end
