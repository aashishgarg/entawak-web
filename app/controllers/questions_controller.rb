class QuestionsController < ApplicationController

  ########## Layouts ########################
  layout 'students'

  ########## Filters ########################
  skip_before_action :authenticate_teacher!
  before_action :set_question

  def show
    @team = @question.questionaire.team
  end

  def submit
    team = @question.questionaire.team
    if params[:question][:answer] == @question.answer && @question.update(answered: true)
      ActionCable.server.broadcast "team_#{team.id}", {'team' => team}
    end
    redirect_to question_team_path(team)
  end

  private

  def set_question
    @question = Question.where(id: params[:id]).take
  end
end
