# frozen_string_literal: true

class HomeController < ApplicationController
  skip_before_action :authenticate

  def index
  end

  def about
  end

  def contact_us
  end

  def pricing
  end
end
