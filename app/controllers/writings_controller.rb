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
      flash[:success] = 'You have successfully created a writing'
      redirect_to writings_path
    else 
      flash.now[:error] = @writing.errors.full_messages.to_sentence
      render :index
    end
  end

  private 
  def set_task
    @task = Task.find(params[:task_id])
  end
  def writing_params
    params.require(:writing).permit(:answer, :task_id)
  end
end
