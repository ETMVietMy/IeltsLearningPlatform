class TeachersController < ApplicationController
  layout 'dashboard'

  def index
    @teachers = Teacher.all
  end



  def show
    @teacher = Teacher.find(params[:id])
    @comments = Comment.where(teacher_id: @teacher)
    @comment = Comment.new
    if @teacher.comments.blank?
      @average_review = 0
    else
      @average_review = @teacher.comments.average(:rating).round(2)
    end
    
  end

  def new
    @teacher = Teacher.new(user: current_user)
  end

  def create
    @teacher = Teacher.new(teacher_params)

    if @teacher.invalid?
      flash.now[:error] = @teacher.errors.full_messages.to_sentence
      return render :new
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

  def search
    @teachers = Teacher.search(params)
  end

  private
  def teacher_params
    params.require(:teacher).permit(:user_id, :experience, :nationality, :price, :linkedin)
  end
end
