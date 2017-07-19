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
        Recipient.create(user_id: recipient.id, message_id: @message.id)
        flash[:success] = "Your message has been sent."
        redirect_to messages_sent_path
      else
        flash[:error] = "ERROR: #{@message.errors.full_messages.to_sentence}"
        redirect_to new_message_path
      end
    end
  end

  def accept_request
    reply_request(true)
  end

  def deny_request
    reply_request(false)
  end

  def sent
    @messages = current_user.sent_messages
  end

  private
  def reply_request(is_accepted)
    @request = Message.find(params[:message_id])

    unless @request.writing_id.present?
      flash[:error] = "The message doesn't link to any writing"
      redirect_to messages_path
    end

    @writing = Writing.find(@request.writing_id)
    @correction = Correction.new(writing_id: @writing.id, teacher_id: current_user.id, status: 'new')

    Correction.transaction do
      @correction.save!

      if is_accepted
        reply_subject = "Your correcting request has been accepted"
        reply_content = "#{current_user.name_or_username} has accepted your request, please wait for him/her to correct your answer"
      else
        reply_subject = "Your correcting request has been denied"
        reply_content = "#{current_user.name_or_username} has denied your request, please request to another teacher"
      end

      @message = Message.new(
        sender: current_user.id, 
        subject: reply_subject,
        content: reply_content,
        is_read: false
      )
      @recipient = Recipient.new(
        message: @message,
        user_id: @request.sender
      )
      @message.save!
      @recipient.save!
    end

    flash[:success] = 'You have been reply to the request succefully'
    return redirect_to messages_path

    rescue ActiveRecord::RecordInvalid => invalid
      flash[:error] = invalid.record.errors.full_messages.to_sentence
      return redirect_to messages_path
  end
end
