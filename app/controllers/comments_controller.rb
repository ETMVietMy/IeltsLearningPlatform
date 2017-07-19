class CommentsController < ApplicationController
	before_action :authenticate_user!

	def create	
		@teacher = Teacher.find(params[:teacher_id])
		@comment = @teacher.comments.create(comment_params)
		@comment.user_id = current_user
		if @comment.save
			flash[:success] = "New Comment posted!"
			redirect_to teacher_path(@teacher)
		else
			flash[:error] = "Unable to post!"
			redirect_to teacher_path(@teacher)
	end
end


	private

	def comment_params
		params.require(:comment).permit(:message, :rating)
	end
end
