class WritingsController < ApplicationController
  layout 'dashboard'

  before_action :set_task, only: [:new]

  def index
    @writings = current_user.writings
  end

  def show
    @writing = Writing.find(params[:id])
    @task = @writing.task
  end

  def new
    @writing = Writing.new(task: @task)
  end

  def create
    @writing = Writing.new(writing_params)
    @task = Task.find(writing_params[:task_id])
    @writing.user = current_user
    @writing.task_type = @task.task_number
    @writing.task_description = @task.description

    if @writing.save
      flash[:success] = 'You have successfully created a writing, please find a teach to help you correcting'
      redirect_to new_request_path(writing_id: @writing.id) #writings_path
    else 
      flash.now[:error] = @writing.errors.full_messages.to_sentence
      render :index
    end
  end

  def new_request
    @teachers = User.teachers
    @writing = Writing.find(params[:writing_id])
  end

  def create_request
    @writing = Writing.find(params[:writing_id])
    @teacher = User.find(params[:teacher_id])
    @teachers = User.teachers

    @message = Message.new(
      sender: current_user.id,
      subject: "New correcting request from #{current_user.name_or_username}",
      content: "You can either accept or deny this request",
      writing_id: @writing.id,
      is_read: false,
      message_type: Message::REQUEST
    )
    @recipient = Recipient.new(
      message: @message,
      user_id: @teacher.id
    )

    if @message.invalid?
      flash[:error] = @message.errors.full_messages.to_sentence
      return redirect_to new_request_url(@writing)
    end

    if @recipient.invalid?
      flash[:error] = @recipient.errors.full_messages.to_sentence
      return redirect_to new_request_url(@writing)
    end

    Message.transaction do
      @message.save!
      @recipient.save!
      @writing.change_status(Writing::STATUS_REQUESTED)

      # websocket boardcasting
      notify_user(@recipient.id)
    end

    flash[:success] = "Your request has been successfully sent to #{@teacher.name_or_username}"
    redirect_to writings_path

    rescue ActiveRecord::RecordInvalid => invalid
      flash[:error] = invalid.record.errors.full_messages.to_sentence
      return render :new_request
  end

  private 
  def set_task
    @task = Task.find(params[:task_id])
  end
  def writing_params
    params.require(:writing).permit(:answer, :task_id)
  end
end
