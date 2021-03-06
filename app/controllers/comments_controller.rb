class CommentsController < ApplicationController
	before_action :authenticate_user!

	def index
		@comments = Comment.all
	end

	def new
	@teacher = Teacher.find(params[:teacher_id])
  @comment = Comment.new
	end

	def show
		@comment = comment.find_by(params[:id])
		@comments = Comment.where(teacher_id: @teacher)
    @comment = Comment.new
    if @teacher.comments.blank?
      @average_review = 0
    else
      @average_review = @teacher.comments.average(:rating).round(2)
	end
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
	@comment = comment.find(params[:comment_id])
	respond_to do |format|
    if @comment.update_attributes(params[:comment])
        format.js
      end
    end
  end



	private

	def comment_params
		params.require(:comment).permit(:message, :rating)
	end
end
