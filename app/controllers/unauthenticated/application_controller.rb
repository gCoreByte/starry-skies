# frozen_string_literal: true

module Unauthenticated
  class ApplicationController < ActionController::Base
    layout 'unauthenticated'
  end
end
