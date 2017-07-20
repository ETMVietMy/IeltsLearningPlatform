class CorrectionsController < ApplicationController
  before_action :set_correction, only: [:show, :edit, :update]

  def index
    @corrections = current_user.corrections
  end

  def show
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
          subject: 'Your writing has been correcting',
          content: 'Teacher has been finish correcting your writing',
          is_read: false,
          message_type: 'rep'
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
