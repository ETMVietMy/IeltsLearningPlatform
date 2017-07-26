class DashboardController < ApplicationController
  layout  'dashboard'
  before_action :authenticate_user!

  # TODO: fetch user dashboard index
  def index
    @student_graph = Writing.writings_count.map { |k,v| {date: k, value: v} }
    @total_writings = Writing.total_writings(current_user.id)
    @total_unread_messages = Message.total_unread_message(current_user.id)
  end
end
