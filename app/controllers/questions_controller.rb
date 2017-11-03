class QuestionsController < ApplicationController

  ########## Layouts ########################
  layout 'students'

  ########## Filters ########################
  skip_before_action :authenticate_teacher!
  before_action :set_question

  def show
    @team = current_student.team
  end

  def submit
    if params[:question][:answer] == @question.answer && @question.update(answered: true)
      ActionCable.server.broadcast "team_#{current_student.team.id}", {'team' => current_student.team}
      ActionCable.server.broadcast "game_#{current_student.game.id}", {'score' => current_student.game}
    end
    redirect_to question_teams_path(current_student.team)
  end

  private

  def set_question
    @question = Question.where(id: params[:id]).take
  end
end
