class TasksController < ApplicationController
  layout 'dashboard'

	def index
		@tasks = Task.all
	end

	def new
		@tasks = Task.new
	end

	def show
		@tasks = Task.find_by(params[:id])
	end

	def suggest
		@task = Task.new
	end

	def create
		@task = Task.new(task_params)
		if @task.save
			if params[:next_location] == 'writing'
				redirect_to new_writing_path(task_id: @task.id)
			else
				redirect_to 'index'
			end
		else
			render :suggest
		end
	end

	private

	def task_params
		params.require(:task).permit(:description, :task_number)
	end
end
