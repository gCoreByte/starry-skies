# frozen_string_literal: true

RSpec::Matchers.define :have_translated_error_messages do
  supports_block_expectations

  match do |actual|
    @errors =
      case actual
      when ActiveModel::Model
        actual.errors.to_hash(true)
      else
        actual
      end

    @errors.is_a?(Hash) && not_translated_messages.empty?
  end

  failure_message do
    if @errors.is_a?(Hash)
      <<~MSG
        Expected #{@errors} all error messages to be translated

        Untranslated error messages:
          #{not_translated_messages.inspect}
      MSG
    else
      <<~MSG
        Expected #{@errors} to be error messages hash
      MSG
    end
  end

  private

  def missing_translation_whitelist
    # Translation missing format changed in i18n version 1.14.0
    # https://github.com/ruby-i18n/i18n/pull/654
    ['translation missing:', 'Translation missing']
  end

  def not_translated_messages
    @_not_translated_messages ||= [].tap do |untranslated|
      (@errors['messages'] || @errors).each_value do |messages|
        messages.each do |message|
          untranslated << message if message.start_with?(*missing_translation_whitelist)
        end
      end
    end
  end
end
