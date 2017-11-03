class ApplicationController < ActionController::Base

  ######### Protect from forgery ###################
  protect_from_forgery with: :exception

  ########## Filters ###############################
  before_action :authenticate_teacher!
  before_action :current_student
  add_flash_types :success, :warning, :danger, :info

  helper_method :current_student

  def current_student
    Student.find_by(id: session[:student_id])
  end
end
