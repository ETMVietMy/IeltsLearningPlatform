class FollowsController < ApplicationController
  layout 'dashboard'
  
  def index
    @teachers = current_user.getAllFollowedTeachers
  end

  def create
    Follow.create(user_id: current_user.id, teacher_id: params[:id])
    @teachers = Teacher.all
  end

  def destroy
    @follow = Follow.find_by(user_id: current_user.id, teacher_id: params[:id])
    @follow.destroy
    @teachers = current_user.getAllFollowedTeachers
  end
end
