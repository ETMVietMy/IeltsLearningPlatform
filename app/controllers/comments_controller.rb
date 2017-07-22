class CommentsController < ApplicationController
	before_action :authenticate_user!

	def new
		@comment = Comment.new
	end

	def show
		@comment = comment.find_by(params[:id])
	end


	def create	
		@teacher = Teacher.find(params[:teacher_id])
		@comment = @teacher.comments.create(comment_params.merge(user: current_user))
		if @comment.save
			flash[:success] = "New Comment posted!"
			redirect_to teacher_path(@teacher)
		else
			flash[:error] = "Unable to post!"
			redirect_to teacher_path(@teacher)
	end
end

	def update
		if @comment.update(comment_params)
			flash[:success] = "Update completed!"
			redirect_to teacher_path(@teacher)
		else
			flash[:error] = "Your information was not saved"
			redirect_to teacher_path(@teacher)
	end
end

	private

	def comment_params
		params.require(:comment).permit(:message, :rating, :score)
	end
end
