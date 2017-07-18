class CommentsController < ApplicationController
	before_action :authenticate_user!


	def create
		@teacher = Teacher.find_by(id: params[:id])
		@teacher.comments.create(comment_params.merge(user: current_user))
		redirect_to teacher_path(@teacher)
	end

	private

	def comments_params
		params.require(:comment).permit(:message, :rating)
	end
end
