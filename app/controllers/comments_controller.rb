class CommentsController < ApplicationController
	before_action :authenticate_user!


	def create
		@teacher = Teacher.find(params[:teacher_id])
		@teacher.comments.create(comment_params)
		redirect_to teacher_path(@teacher)
	end


	private

	def comment_params
		params.require(:comment).permit(:message, :rating)
	end
end
