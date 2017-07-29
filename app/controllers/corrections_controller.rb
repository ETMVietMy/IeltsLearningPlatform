class CorrectionsController < ApplicationController
  before_action :set_correction, only: [:show, :edit, :update]
  before_action :require_teacher

  def index
    if current_user.is_admin?
      @corrections = Correction.where(status: [Correction::STATUS_DENIED, Correction::STATUS_DENY_CONFIRMED, Correction::STATUS_DENY_REFUSED])
    else
      @corrections = current_user.corrections
    end
  end

  def show
    @correction = Correction.find_by(id: params[:id])
  end

  def edit
  end

  def update
    if @correction.update_attributes(correction_params)
      if params[:save].present?
        flash[:success] = "You have save your corrections"
        redirect_to corrections_path
      elsif params[:finish].present?
        @correction.update_attribute(:status, 'done')
        # send message
        @message = Message.new(sender: current_user.id,
          subject: 'Your writing has been finished',
          content: 'Teacher has been finish correcting your writing',
          is_read: false,
          writing_id: @writing.id,
          message_type: Message::CORRECTION
        )
        @recipient = Recipient.new(message: @message,
          user_id: @writing.user_id
        )

        @message.transaction do
          @message.save!
          @recipient.save!
        end

        flash[:success] = "You have finish your corrections"
        redirect_to corrections_path
      end
    else
      flash[:error] = @correction.errors.full_messages.to_sentence
      render :edit
    end


    rescue ActiveRecord::RecordInvalid => invalid
      flash[:error] = invalid.record.errors.full_messages.to_sentence
      return render :edit
  end

  def accept_deny_correction
    @correction = Correction.find_by(id: params[:id])
    @correction.status = Correction::STATUS_DENY_CONFIRMED
    flash[:success] = "Correction deny accepted!"
    @correction.save
    Account.cancel_payment_for_correcting(@correction.get_user_student.account.id, @correction.get_teacher_account.id, @correction.get_teacher.price, @correction.writing.id)
    return redirect_to corrections_path
  end

  def refuse_deny_correction
    @correction = Correction.find_by(id: params[:id])
    @correction.status = Correction::STATUS_DENY_REFUSED
    flash[:success] = "Correction deny refused!"
    @correction.save
    Account.settle_payment_for_correcting(@correction.get_user_student.account.id, @correction.get_teacher_account.id, @correction.get_teacher.price, @correction.writing.id)
    return redirect_to corrections_path
  end

  private
  def set_correction
    @correction = Correction.find(params[:id])
    @writing = @correction.writing
    @task = @writing.task
  end

  def correction_params
    params.require(:correction).permit(:body, :task_achievement ,:coherence_cohesion, :lexical_resource, :grammar)
  end

end
