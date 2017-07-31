class HomeController < ApplicationController
  layout 'application'
  def index
    @teachers = Teacher.random_teachers
  end
end
