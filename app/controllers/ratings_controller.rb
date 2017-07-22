class RatingsController < ApplicationController

	def new
		@rating = Rating.new
	end

	def create
		@rating = Rating.new(rating_params)
		@rating.user_id = user.id
		@rating.user_id = current_user.id

		if @rating.save
			flash[:success] = "You have rated the teacher"
			redirect_to teacher_path(@teacher)
		else
			flash[:error] = "Your rating was not saved"
			redirect_to teacher_path(@teacher)
		end
	end

	def update
	@comment = Comment.find(params[:comment_id])
    @comment = @rating.comment
    if @rating.update_attributes(score: params[:score])
      respond_to do |format|
        format.js
      end
    end
  end

  private

  def rating_params
  	params.require(:rating).permit(:score, :rating)
 	end
end

