class TeamsController < ApplicationController

  ########## Filters ########################
  skip_before_action :authenticate_teacher!, except: [:assign]
  before_action :fetch_team, only: [:show, :question, :scream]

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

  def scream
    if @team.hint_counter > 0 && @team.update(hint_counter: @team.hint_counter-1)
      ActionCable.server.broadcast "team_#{@team.id}", {'team_scream' => @team}
    end
  end

  private
  def fetch_team
    @team = Team.find_by(id: params[:id])
  end

end
