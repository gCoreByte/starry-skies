# frozen_string_literal: true

module Admin
  class DocumentationsController < Admin::ApplicationController
    def variables
      @variables = Documentations::Variables.new.all
    end

    def guide
      file = Rails.root.join("app/views/admin/documentations/guide/#{I18n.locale}.md")
      @content = ::MARKDOWN_RENDERER.render(file.read)
    end
  end
end
