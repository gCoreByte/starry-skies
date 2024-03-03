# frozen_string_literal: true

RSpec::Matchers.define :validate_errors_on do |attribute|
  match do |model|
    @model = model
    @attribute = attribute || raise(ArgumentError, 'Attribute missing')
    @model.invalid? && @model.errors[@attribute].present? &&
      error_message_matches && error_detail_matches && error_details_matches
  end

  chain :with_message do |*message|
    @message = message
  end

  chain :with_detail do |detail|
    @detail = detail
  end

  chain :with_details do |*details|
    @details = details
  end

  failure_message do
    errors = []
    errors << 'be invalid' if @model.errors.blank?
    errors << "have errors on #{@attribute}" if @model.errors[@attribute].blank?
    errors << "have #{@message} error on #{@attribute}" unless error_message_matches
    errors << "have #{@details} error on #{@attribute}" unless error_details_matches

    <<~MSG
      Expected #{@model} #{errors.join(' and ')}

      The record had following errors:
        #{@model.errors[@attribute].inspect}

      With details:
        #{@model.errors.details[@attribute].inspect}
    MSG
  end

  failure_message_when_negated do
    <<~MSG
      Expected #{@model} not to have errors on #{@attribute}

      The record had following errors:
        #{@model.errors[@attribute].inspect}

      With details:
        #{@model.errors.details[@attribute].inspect}
    MSG
  end

  description do
    if @message
      "have error #{@message.inspect} on #{expected.inspect}"
    else
      "have errors on #{expected.inspect}"
    end
  end

  private

  def error_message_matches
    return true if @message.nil?

    Array.wrap(@message).all? do |message_key|
      if message_key.is_a?(Hash)
        message_key.all? { |key, key_options| includes_message?(key, key_options) }
      else
        includes_message?(message_key)
      end
    end
  end

  def error_details_matches
    return true if @details.nil?

    @details.all? do |error_detail|
      expect(@model.errors.details[@attribute]).to include(a_hash_including(error_detail))
    end
  end

  def error_detail_matches
    return true if @detail.nil?

    @model.errors.details[@attribute].include?(@detail)
  end

  def includes_message?(key, key_options = {})
    message = @model.errors.generate_message(@attribute, key, key_options)
    @model.errors[@attribute].include?(message)
  end
end
