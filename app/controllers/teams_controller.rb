class TeamsController < ApplicationController

  ########## Filters ########################
  skip_before_action :authenticate_teacher!, except: [:assign]
  skip_before_action :current_student, only: [:assign]

  ########## Layouts ########################
  layout 'game_layout', only: [:assign]
  layout 'students', only: [:show, :question, :game_over]

  def assign
    @game = current_teacher.games.find_by(id: params[:game_id])
    @game.assign_team_and_students
    if @game.teams.present?
      @game.broadcast_team
    else
      redirect_to active_students_game_path(@game), info: 'Minimum four students is required.'
    end
  end

  def show
    @team = current_student&.team
  end

  def question
    @team = current_student&.team
    if @team && @team.game.state
      @question = @team.questions.where(answered: false).take
      unless @question
        ActionCable.server.broadcast "student_#{current_student.id}", {game_over: current_student}
        redirect_to game_over_teams_path
      end
    else
      redirect_to pause_game_path(current_student&.game)
    end
  end

  def scream
    @team = current_student&.team
    if @team.hint_counter > 0 && @team.update(hint_counter: @team.hint_counter-1)
      ActionCable.server.broadcast "team_#{@team.id}", {'team_scream' => @team}
      ActionCable.server.broadcast "game_#{@team.game.id}", {'hint' => @team}
    end
  end

  def game_over

  end

end
