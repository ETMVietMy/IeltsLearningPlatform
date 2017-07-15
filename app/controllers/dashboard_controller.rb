class DashboardController < ApplicationController
  layout  'dashboard'
  before_action :authenticate_user!

  # TODO: fetch user dashboard index
  def index

  end
end
