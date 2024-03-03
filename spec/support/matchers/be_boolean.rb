# frozen_string_literal: true

RSpec::Matchers.define :be_boolean do
  match do |actual|
    [true, false].include?(actual)
  end

  failure_message do
    <<~MSG
      Expected #{actual} to be boolean, but was #{actual.inspect} (#{actual.class})
    MSG
  end
end
