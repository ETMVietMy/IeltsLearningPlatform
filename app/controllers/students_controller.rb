class StudentsController < ApplicationController

	def show
		@students = Student.find_by(params[:id])
	end

	private

	def student_params
		params.require(:student).permit(:name, :email, :user_id)
	end
end
