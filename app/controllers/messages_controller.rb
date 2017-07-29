class MessagesController < ApplicationController
  layout 'dashboard'

  def index
    @messages = current_user.received_messages
  end

  def new
  end

  def show
    @message = Message.find_by(id: params[:id])
    @writing = nil
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    if @message
      if !@message.is_read
        @message.is_read = true
        @message.save
      end
      if @message.request? || @message.correction?
        @writing = Writing.find_by(id: @message.writing_id)
      end
    else
      flash[:error] = "ERROR: Cannot get data of the message!"
      redirect_to messages_path
    end
  end

  def create
    @message = Message.new(message_params)

    if @message.recipients_emails.nil? || @message.recipients_emails.strip==""
      flash[:error] = "ERROR: Message cannot send without recipient."
      redirect_to new_message_path
      return
    else
      recipient = User.find_by(email: @message.recipients_emails)
      if recipient.nil?
        flash[:error] = "ERROR: Cannot find User with email '#{@message.recipients_emails}'!"
        redirect_to new_message_path
        return
      end

      @message.sender = current_user.id
      @message.is_read = false

      if @message.save
        Recipient.create(user_id: recipient.id, message_id: @message.id)
        # change writing status
        if @message.writing_id.present?
          Writing.find(@message.writing_id).change_status(Writing::STATUS_REQUESTED)
        end

        flash[:success] = "Your message has been sent."
        redirect_to messages_sent_path
      else
        flash[:error] = "ERROR: #{@message.errors.full_messages.to_sentence}"
        redirect_to new_message_path
      end
    end
  end

  def destroy
    @message = Message.find_by(id: params[:id])
    @message.hide_recipient = true
    @message.save
    @messages = current_user.received_messages
  end

  def delete_sent
    @message = Message.find_by(id: params[:id])
    @message.hide_sender = true
    @message.save
    @messages = current_user.sent_messages
  end

  def accept_request
    reply_request(true)
  end

  def deny_request
    reply_request(false)
  end

  def accept_correction
    reply_correction(true)
    # handle_reply(
    #   params[:message_id],
    #   true,
    #   "Your correcting has been accepted",
    #   "#{current_user.name_or_username} has accepted your correcting",
    #   "You have been accepted the correcting succefully"
    # )
    #def handle_reply(message_id, is_accepted, reply_subject, reply_content, success_flash = 'You have been reply to the request succefully')

  end
  def deny_correction
    reply_correction(false)
    # handle_reply(
    #   params[:message_id],
    #   false,
    #   "Your correcting request has been denied",
    #   "#{current_user.name_or_username} has denied your correting, please review and update it",
    #   "You have been accepted the correcting succefully"
    # )
  end

  def sent
    @messages = current_user.sent_messages
  end

  private

  def message_params
    params.require(:message).permit(:subject, :content, :message_type, :writing_id, :recipients_emails)
  end

  # handle request
  def reply_request(is_accepted)
    @request = Message.find(params[:message_id])

    unless @request.writing_id.present?
      flash[:error] = "ERROR: The message doesn't link to any writing"
      redirect_to messages_path
    end

    @writing = Writing.find(@request.writing_id)
    @correction = Correction.new(writing_id: @writing.id, teacher_id: current_user.id, status: Correction::STATUS_NEW)

    Correction.transaction do
      if is_accepted
        @correction.save!
        reply_subject = "Your correcting request has been accepted"
        reply_content = "#{current_user.name_or_username} has accepted your request, please wait for him/her to correct your answer"
        Account.start_payment_for_correcting(@writing.user.account.id, current_user.account.id, current_user.teacher.price, @writing.id)
        # change status of writing
        @writing.change_status(Writing::STATUS_CORRECTING)
      else
        reply_subject = "Your correcting request has been denied"
        reply_content = "#{current_user.name_or_username} has denied your request, please request to another teacher"
        # change status of writing
        @writing.change_status(Writing::STATUS_NEW)
      end

      @message = Message.new(
        sender: "Notification",
        subject: reply_subject,
        content: reply_content,
        message_type: Message::NOTIFICATION,
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

  #handle correction
  def reply_correction(is_accepted)
    @request = Message.find(params[:message_id])

    unless @request.writing_id.present?
      flash[:error] = "ERROR: The message doesn't link to any writing"
      redirect_to messages_path
    end

    @writing = Writing.find(@request.writing_id)
    @correction = @writing.correction
    if is_accepted
      @correction.assign_attributes(status: Correction::STATUS_ACCEPTED)
    else
      @correction.assign_attributes(status: Correction::STATUS_DENIED)
    end

    Correction.transaction do
      @correction.save!

      if is_accepted
        reply_subject = "Your correcting has been accepted"
        reply_content = "#{current_user.name_or_username} has accepted your correcting"
        Account.settle_payment_for_correcting(current_user.account.id, @correction.get_teacher_account.id, @correction.get_teacher.price, @writing.id)
      else
        reply_subject = "Your correcting request has been denied"
        reply_content = "#{current_user.name_or_username} has denied your correting, please review and update it"
      end

      @message = Message.new(
        sender: "Notification",
        subject: reply_subject,
        content: reply_content,
        message_type: Message::NOTIFICATION,
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

  def handle_reply(message_id, is_accepted, reply_subject, reply_content, success_flash = 'You have been reply to the request succefully')
    @request = Message.find(message_id)

    unless @request.writing_id.present?
      flash[:error] = "ERROR: The message doesn't link to any writing"
      redirect_to messages_path
    end

    @writing = Writing.find(@request.writing_id)
    @correction = @writing.correction || Correction.new(writing_id: @writing.id, teacher_id: current_user.id, status: Correction::STATUS_NEW)

    if @correction.new_record?
      if is_accepted
        @correction.assign_attributes(status: Correction::STATUS_ACCEPTED)
      else
        @correction.assign_attributes(status: Correction::STATUS_DENIED)
      end
    end

    Correction.transaction do
      @correction.save!

      # if is_accepted
      #   reply_subject = "Your correcting has been accepted"
      #   reply_content = "#{current_user.name_or_username} has accepted your correcting"
      # else
      #   reply_subject = "Your correcting request has been denied"
      #   reply_content = "#{current_user.name_or_username} has denied your correting, please review and update it"
      # end

      if is_accepted
        Account.settle_payment_for_correcting(current_user.account.id, @correction.get_teacher_account.id, @correction.get_teacher.price, @writing.id)
      end
      @message = Message.new(
        sender: "Notification",
        subject: reply_subject,
        content: reply_content,
        message_type: Message::NOTIFICATION,
        is_read: false
      )
      @recipient = Recipient.new(
        message: @message,
        user_id: @request.sender
      )
      @message.save!
      @recipient.save!
    end

    flash[:success] = success_flash
    return redirect_to messages_path

    rescue ActiveRecord::RecordInvalid => invalid
      flash[:error] = invalid.record.errors.full_messages.to_sentence
      return redirect_to messages_path
  end
end
