class GamesController < ApplicationController

  layout 'game_layout', except: [:introduction]

  before_action :fetch_game, only: [:update]

  def introduction
  end

  def new
    @game = current_teacher.games.create
  end

  def create

  end

  def update
    if @game.update(missing_devices: params[:game][:missing_devices])
      redirect_to games_introduction_path
    else
      redirect_to :back
    end
  end

  private

  def fetch_game
    @game = current_teacher.games.find(params[:id])
  end

end
