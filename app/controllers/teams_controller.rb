class TeamsController < ApplicationController

  ########## Filters ########################
  skip_before_action :authenticate_teacher!, except: [:assign]
  before_action :fetch_team, only: [:show, :question]

  ########## Layouts ########################
  layout 'game_layout', only: [:assign]
  layout 'students', only: [:show, :question]

  def assign
    @game = current_teacher.games.find_by(id: params[:game_id])
    @game.assign_team_and_students
    if @game.teams.present?
      @game.broadcast_team
    else
      redirect_to active_students_game_path(@game)
    end
  end

  def show
  end

  def question
    @question = @team.questions.where(answered: false).take
  end

  private
  def fetch_team
    @team = Team.find_by(id: params[:id])
  end

end
