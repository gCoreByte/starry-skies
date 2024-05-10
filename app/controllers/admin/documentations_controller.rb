# frozen_string_literal: true

module Admin
  class DocumentationsController < Admin::ApplicationController
    def variables
      @variables = Documentations::Variables.new.all
    end
  end
end
