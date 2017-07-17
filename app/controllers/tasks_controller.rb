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

	private

	def task_params
		params.require(:task).permit(:description, :task_number)
	end
end
