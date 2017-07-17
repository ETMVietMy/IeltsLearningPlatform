class WritingsController < ApplicationController
  layout 'dashboard'
  before_action :set_task, only: [:new, :create]

  def index
  end

  def new
    @writing = Writing.new(task: @task)
  end

  def create
    @writing = Writing.new(task: @task)
  end

  private 
  def set_task
    @task = Task.find(params[:task_id])
  end
  def writing_params
    params.require(:writing).permit(:answer)
  end
end
