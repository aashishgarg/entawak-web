class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_teacher!

  def after_sign_in_path_for(resource)
    games_introduction_path
  end

end
