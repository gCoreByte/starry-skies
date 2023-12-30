# frozen_string_literal: true

module Admin
  class DashboardController < Admin::ApplicationController
    def index
      @stores = current_user.stores
    end
  end
end
