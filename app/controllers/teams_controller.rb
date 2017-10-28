class TeamsController < ApplicationController

  ########## Filters ########################
  skip_before_action :authenticate_teacher!, except: [:assign]
  before_action :fetch_team, only: [:show, :question, :scream, :game_over]

  ########## Layouts ########################
  layout 'game_layout', only: [:assign]
  layout 'students', only: [:show, :question, :game_over]

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
    if @team.game.state
      @question = @team.questions.where(answered: false).take
      ActionCable.server.broadcast "student_#{current_student.id}", {game_over: current_student} unless @question
    else
      redirect_to pause_game_path(@team.game)
    end
  end

  def scream
    if @team.hint_counter > 0 && @team.update(hint_counter: @team.hint_counter-1)
      ActionCable.server.broadcast "team_#{@team.id}", {'team_scream' => @team}
      ActionCable.server.broadcast "game_#{@team.game.id}", {'hint' => @team.game}
    end
  end

  def game_over

  end


  private
  def fetch_team
    @team = Team.find_by(id: params[:id])
  end

end
