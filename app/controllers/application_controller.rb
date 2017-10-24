class ApplicationController < ActionController::Base

  ######### Protect from forgery ###################
  protect_from_forgery with: :exception

  ########## Filters ###############################
  before_action :authenticate_teacher!
  after_action :prepare_unobtrusive_flash

  def after_sign_in_path_for(resource)
    new_game_path
  end

end
