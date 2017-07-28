class AccountController < ApplicationController
  layout  'dashboard'
  before_action :authenticate_user!
  before_action :require_teacher, only: [:edit_teacher, :update_teacher]
  
  def index
    @account = current_user
  end

  def update
    @account = current_user

    @account.transaction do 
      @account.update_attributes(user_params)

      # remove old attachment
      if avatar_param.present?
        @account.attachment.destroy!
        
        @avatar = Attachment.new
        @avatar.attached_item = @account
        @avatar.attachment = avatar_param
        @avatar.save!
      end
    end

    flash[:success] = 'Your infromation has been updated successfully'
    return redirect_to :account

    rescue ActiveRecord::RecordInvalid => invalid
      flash[:error] = invalid.record.errors.full_messages.to_sentence
      return render :edit
  end

  def edit
    @account = current_user
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

  def user_params 
    params.require(:user).permit(:name)
  end

  def avatar_param
    params.require(:user).permit(:avatar)[:avatar]
  end
end
