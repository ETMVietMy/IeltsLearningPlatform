class HomeController < ApplicationController
  def index
  end

  def dashboard
    render layout: 'dashboard'
  end
end
