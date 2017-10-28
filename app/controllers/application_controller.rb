class ApplicationController < ActionController::Base

  ######### Protect from forgery ###################
  protect_from_forgery with: :exception

  ########## Filters ###############################
  before_action :authenticate_teacher!
  before_action :current_student
  after_action :prepare_unobtrusive_flash

  helper_method :current_student

  # def after_sign_in_path_for(resource)
  #   new_game_path if resource.is_a?(Teacher)
  # end

  def current_student
    Student.find_by(id: session[:student_id])
  end
end
