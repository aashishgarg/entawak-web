class TeamsController < ApplicationController

  ########## Filters ########################
  skip_before_action :authenticate_teacher!, except: [:assign]
  before_action :fetch_team, only: [:show]

  ########## Layouts ########################
  layout 'game_layout', only: [:assign]
  layout 'students', only: [:show]

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

  private
  def fetch_team
    @team = Team.find_by(id: params[:id])
  end

end
