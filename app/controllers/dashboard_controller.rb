class DashboardController < ApplicationController
  layout  'dashboard'
  before_action :authenticate_user!

  # TODO: fetch user dashboard index
  def index
    @student_graph = Writing.writings_count.map { |item| {date: item.date, value: item.count} }
  end
end
