class GamesController < ApplicationController

  ########## Layouts ########################
  layout 'game_layout', except: [:introduction]

  ########## Filters ########################
  before_action :fetch_game, only: [:update, :active_students, :team_assigmnent]

  def introduction
  end

  def new
    @game = current_teacher.games.create
  end

  def create

  end

  def update
    if @game.update(missing_devices: params[:game][:missing_devices])
      redirect_to active_students_game_path(@game)
    else
      redirect_to :back
    end
  end

  def show

  end

  def active_students
    cookies.signed[:game_id] = @game.id
  end

  def team_assigmnent
    @game.assign_team_and_students
  end

  private

  def fetch_game
    @game = current_teacher.games.find(params[:id])
  end

end
