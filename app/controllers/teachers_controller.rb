class TeachersController < ApplicationController
  layout 'dashboard'

  def index
    @teachers = Teacher.new
  end

  def new
    @teacher = Teacher.new(user: current_user)
  end

  def create
    @teacher = Teacher.new(teacher_params)
    unless @teacher.valid?
      flash.now[:error] = @teacher.errors.full_messages.to_sentence
      render :new
    end

    Teacher.transaction do
      @teacher.save!
      current_user.update_attributes(role: 'TEC')
    end

    flash[:success] = "You have registered successfully as a teacher"
    redirect_to dashboard_path
      
  end

  def edit
  end

  def update
  end

  private 
  def teacher_params
    params.require(:teacher).permit(:user_id, :experience, :nationality, :price, :linkedin)
  end
end
