class QuestionsController < ApplicationController

  ########## Layouts ########################
  layout 'game_layout', except: [:introduction]
  skip_before_action :authenticate_teacher!

  def show
    @question = Question.where(id: params[:id]).take
  end

  def submit
  question = Question.where(id: params[:id]).take
    if params[:question][:answer]== question.answer
      question.move_to_next_question
    end
  end
end
