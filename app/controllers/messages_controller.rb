class MessagesController < ApplicationController
  layout 'dashboard'

  def index
    @messages = current_user.received_messages
  end

  def new
  end

  def show
    @message = Message.find_by(id: params[:id])
    if @message
      if !@message.is_read
        @message.is_read = true
        @message.save
      end
    else
      flash[:error] = "Cannot get data of the message!"
      redirect_to messages_path
    end
  end

  def create
    if params[:addresses].nil? || params[:addresses].strip==""
      flash[:error] = "Message cannot send without recipient."
      redirect_to new_message_path
      return
    else
      recipient = User.find_by(email: params[:addresses])
      if recipient.nil?
        flash[:error] = "Cannot find User with email '#{params[:addresses]}'!"
        redirect_to new_message_path
        return
      end

      @message = Message.new
      @message.sender = current_user.id
      @message.subject = params[:subject]
      @message.content = params[:content]
      @message.is_read = false

      if @message.save
        Recipient.create(user_id: @user.id, message_id: @message.id)
        flash[:success] = "Your message has been sent."
        redirect_to messages_sent_path
      else
        flash[:error] = "ERROR: #{@message.errors.full_messages.to_sentence}"
        redirect_to new_message_path
      end
    end
  end

  def sent
    @messages = current_user.sent_messages
  end
end
