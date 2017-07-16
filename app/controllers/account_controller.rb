class AccountController < ApplicationController
  layout  'dashboard'
  before_action :authenticate_user!
  before_action :require_teacher, only: [:edit_teacher, :update_teacher]
  
  def index
    @account = current_user
  end

  def update
  end

  def edit
  end

  def change_password
  end

  def edit_teacher
    @teacher = current_user.teacher
  end
  
  def update_teacher
    @teacher = current_user.teacher
    @teacher.assign_attributes(teacher_params)

    if @teacher.invalid?
      flash[:error] = @teacher.errors.full_messages.to_sentence
      return render 'edit_teacher'
    else
      flash[:success] = "You have updated teacher information"
      @teacher.save
      return redirect_to account_path
    end
  end

  private 
  def teacher_params
    params.require(:teacher).permit(:experience, :nationality, :price, :linkedin)
  end
end
