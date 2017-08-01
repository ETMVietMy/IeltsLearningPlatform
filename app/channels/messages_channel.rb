class MessagesChannel < ApplicationCable::Channel
  include ApplicationHelper

  def subscribed
    # stream_from "some_channel"
    stream_from "message_#{params[:user]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def notify(receiver)
    message = "You have a <a href='#{Rails.application.routes.url_helpers.messages_path}'>new message</a>"
    ActionCable.server.broadcast("message_1", content: message)
  end

  def test(data)
    ActionCable.server.broadcast("message_#{params[:user]}", message: data["message"])
  end

end
