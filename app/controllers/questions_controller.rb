class QuestionsController < ApplicationController

  ########## Layouts ########################
  layout 'game_layout', except: [:introduction]
  skip_before_action :authenticate_teacher!

  def show

  end
end
