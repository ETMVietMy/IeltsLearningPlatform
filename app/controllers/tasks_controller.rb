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
		@suggest_task = Task.order("RANDOM()").first
		@task = Task.new
		@attachment = Attachment.new
	end

	def create
		@task = Task.new(task_params)
		@attachment = Attachment.new
		@attachment.attached_item = @task
		@attachment.attachment = attachment_params[:attachment]

		# validate task
		if @task.invalid?
			flash.now[:error] = @task.errors.full_messages.to_sentence
			return render :suggest
		end

		# validate attachment
		if @attachment.invalid?
			flash.now[:error] = @attachment.errors.full_messages.to_sentence
			return render :suggest
		end

		# save task
		Task.transaction do
			@attachment.save!
			@task.attachments << @attachment
			@task.save!
		end

		if params[:next_location] == 'writing'
			redirect_to new_writing_path(task_id: @task.id)
		else
			redirect_to 'index'
		end
	end

	private

	def task_params
		params.require(:task).permit(:description, :task_number)
	end
	def attachment_params
		params.require(:attachment).permit(:attachment)
	end
end
